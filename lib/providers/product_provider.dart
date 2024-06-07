import 'package:estore/domain/models/models.dart';
import 'package:estore/domain/models/product_model.dart';
import 'package:flutter/foundation.dart';

class ProductProvider extends ChangeNotifier {
  final List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  void onButtonTapped({required bool create, required ProductModel product}) {
    if (create) {
      createProduct(product);
    } else {
      updateProduct(product);
    }
  }

  void createProduct(ProductModel product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(ProductModel updatedProduct) {
    int index =
        _products.indexWhere((product) => product.id == updatedProduct.id);
    if (index != -1) {
      _products[index] = updatedProduct;
      notifyListeners();
    }
  }

  void deleteProduct(int productId) {
    _products.removeWhere((product) => product.id == productId);
    notifyListeners();
  }
}
