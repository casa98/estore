import 'package:dartz/dartz.dart';

import '../models/models.dart';
import '../services/product_service.dart';
import 'product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductService _productService;

  ProductRepositoryImpl(this._productService);

  @override
  Future<Either<String, List<ProductModel>>> getProducts() async {
    return await _productService.fetchProducts();
  }

  @override
  Future<Either<String, List<CategoryModel>>> getCategories() async {
    return await _productService.fetchCategories();
  }

  @override
  Future<Either<String, ProductModel>> getProductById(int id) async {
    return await _productService.fetchProductById(id);
  }
}
