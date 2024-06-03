import 'package:estore/domain/repositories/local_product_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:estore/domain/models/product.dart';

class LocalProductRepositoryImpl implements LocalProductRepository {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('products.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) => _createDB(db),
    );
  }

  Future<void> _createDB(Database db) async {
    await db.execute('''
      CREATE TABLE Product(
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        price TEXT NOT NULL,
        category TEXT NOT NULL,
        description TEXT NOT NULL,
        image TEXT NOT NULL
      )
    ''');
  }

  @override
  Future<List<Product>> getProducts() async {
    final db = await database;
    final productsAsMap = await db.query('Product');
    if (productsAsMap.isEmpty) return [];
    return List<Product>.from(
      productsAsMap.map((productAsMap) => Product.fromJson(productAsMap)),
    );
  }

  @override
  Future<int> insertProduct(Product product) async {
    final db = await database;
    return db.insert(
      'Product',
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int> updateProduct(Product product) async {
    final db = await database;
    return db.update(
      'Product',
      product.toJson(),
      where: 'id = ?',
      whereArgs: [product.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int> deleteProduct(int productId) async {
    final db = await database;
    return db.delete(
      'Product',
      where: 'id = ?',
      whereArgs: [productId],
    );
  }
}
