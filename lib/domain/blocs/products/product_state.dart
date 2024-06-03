import 'package:estore/domain/models/product.dart';

enum GetProductsListStatus { none, loading, success, failure }

class ProductState {
  final GetProductsListStatus getProductsListStatus;
  final List<Product> productsList;

  const ProductState({
    this.getProductsListStatus = GetProductsListStatus.none,
    this.productsList = const [],
  });

  ProductState copyWith({
    List<Product>? productsList,
    GetProductsListStatus? getProductsListStatus,
  }) {
    return ProductState(
      productsList: productsList ?? this.productsList,
      getProductsListStatus:
          getProductsListStatus ?? this.getProductsListStatus,
    );
  }
}
