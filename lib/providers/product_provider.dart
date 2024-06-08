// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import '../models/models.dart';
import '../repositories/product_repository.dart';

class ProductProvider with ChangeNotifier {
  final ProductRepository _productRepository;

  ProductProvider(this._productRepository);

  List<ProductModel> _products = [];
  List<CategoryModel> _categories = [];
  ProductModel? _productDetail;
  String? _errorMessage;
  bool _isLoading = false;

  List<ProductModel> get products => _products;
  List<CategoryModel> get categories => _categories;
  ProductModel? get productDetail => _productDetail;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> getProducts() async {
    _isLoading = true;
    notifyListeners();
    final result = await _productRepository.getProducts();

    result.fold(
      (error) {
        _errorMessage = error;
      },
      (products) {
        _products = products;
        print('${products.length} Products fetched:\n');
        for (var product in products) {
          print(product.toString());
        }
        _errorMessage = null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getCategories() async {
    _isLoading = true;
    notifyListeners();

    final result = await _productRepository.getCategories();

    result.fold(
      (error) {
        _errorMessage = error;
      },
      (categories) {
        _categories = categories;
        print('${categories.length} Categories fetched:\n');
        for (var category in categories) {
          print(category.name);
        }
        _errorMessage = null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getProductById(int id) async {
    _isLoading = true;
    notifyListeners();

    final result = await _productRepository.getProductById(id);

    result.fold(
      (error) {
        _errorMessage = error;
      },
      (product) {
        _productDetail = product;
        _errorMessage = null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }
}
