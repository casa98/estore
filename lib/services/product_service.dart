import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:estore/models/models.dart';

class ProductService {
  final String _baseUrl = 'https://fakestoreapi.com/products';

  Future<Either<String, List<ProductModel>>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final products =
            jsonResponse.map((data) => ProductModel.fromJson(data)).toList();
        return Right(products);
      } else {
        return const Left('Failed to load products');
      }
    } catch (e) {
      return Left('An error occurred: $e');
    }
  }

  Future<Either<String, List<CategoryModel>>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/categories'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final categories =
            jsonResponse.map((data) => CategoryModel.fromJson(data)).toList();
        return Right(categories);
      } else {
        return const Left('Failed to load categories');
      }
    } catch (e) {
      return Left('An error occurred: $e');
    }
  }

  Future<Either<String, ProductModel>> fetchProductById(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$id'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final product = ProductModel.fromJson(jsonResponse);
        return Right(product);
      } else {
        return const Left('Failed to load product details');
      }
    } catch (e) {
      return Left('An error occurred: $e');
    }
  }
}
