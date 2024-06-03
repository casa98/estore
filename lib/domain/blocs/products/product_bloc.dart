// ignore_for_file: unused_local_variable

import 'package:estore/domain/repositories/local_product_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:estore/domain/models/product.dart';

import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.localProductRepository) : super(const ProductState());

  final LocalProductRepository localProductRepository;

  void getProductsList() async {
    print('getting products');
    emit(
      state.copyWith(
        getProductsListStatus: GetProductsListStatus.loading,
      ),
    );
    final productsList = await localProductRepository.getProducts();
    print('number of products: ${productsList.length}');
    productsList.forEach(
      (element) => print(element.toJson()),
    );
    emit(
      state.copyWith(
        getProductsListStatus: GetProductsListStatus.success,
        productsList: productsList,
      ),
    );
  }

  void createProduct({required Product product}) async {
    final created = await localProductRepository.insertProduct(product);
    if (kDebugMode) {
      print('created: $created');
    }
    getProductsList();
  }

  void updateProduct({required Product product}) async {
    print('gonna update this product:');
    print(product.toJson());
    final updated = await localProductRepository.updateProduct(product);
    getProductsList();
  }

  void deleteProduct({required int productId}) async {
    final deleted = await localProductRepository.deleteProduct(productId);
    getProductsList();
  }
}
