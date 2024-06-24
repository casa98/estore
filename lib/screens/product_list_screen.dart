import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider = context.read<ProductProvider>();
      if (productProvider.products.isEmpty) {
        context.read<ProductProvider>().getProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (provider.errorMessage != null) {
            return Center(
              child: Text(provider.errorMessage!),
            );
          }
          if (provider.products.isEmpty) {
            return const Center(
              child: Text('No products available.'),
            );
          }
          return ListView.builder(
            itemCount: provider.products.length,
            itemBuilder: (context, index) {
              final product = provider.products[index];
              return ListTile(
                leading: Image.network(product.image, width: 50, height: 50),
                title: Text(product.title),
                subtitle: Text('\$${product.price}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(product.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
