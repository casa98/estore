import 'package:estore/models/models.dart';
import 'package:estore/providers/product_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Product provider unit tests', () {
    late ProductProvider productProvider;

    setUp(() {
      productProvider = ProductProvider();
    });

    test('Initial products empty', () {
      expect(productProvider.products.length, 0);
    });

    test('inserts product', () {
      final product = ProductModel(
        id: 1,
        title: 'title',
        price: 'price',
        category: 'category',
        description: 'description',
      );
      productProvider.createProduct(product);
      expect(productProvider.products.length, 1);
    });

    test('updates product', () {
      final product = ProductModel(
        id: 1,
        title: 'title',
        price: 'price',
        category: 'category',
        description: 'description',
      );
      productProvider.createProduct(product);

      final updatedProduct = ProductModel(
        id: 1,
        title: 'title updated',
        price: 'price',
        category: 'category',
        description: 'description',
      );
      productProvider.updateProduct(updatedProduct);
      expect(productProvider.products.first.title, 'title updated');
    });

    test('deletes product', () {
      final product = ProductModel(
        id: 1,
        title: 'title',
        price: 'price',
        category: 'category',
        description: 'description',
      );
      productProvider.createProduct(product);
      productProvider.deleteProduct(product.id);
      expect(productProvider.products.isEmpty, true);
    });
  });
}
