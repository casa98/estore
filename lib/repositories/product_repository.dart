import 'package:dartz/dartz.dart';

import '../models/models.dart';

abstract class ProductRepository {
  Future<Either<String, List<ProductModel>>> getProducts();
  Future<Either<String, List<CategoryModel>>> getCategories();
  Future<Either<String, ProductModel>> getProductById(int id);
}
