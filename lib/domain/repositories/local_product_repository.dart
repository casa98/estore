import 'package:estore/domain/models/product.dart';

abstract class LocalProductRepository {
  Future<List<Product>> getProducts();
  Future<int> insertProduct(Product product);
  Future<int> updateProduct(Product product);
  Future<int> deleteProduct(int productId);
}
