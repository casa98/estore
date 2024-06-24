import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  const ProductDetailScreen(this.productId, {super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().getProductById(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
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
          if (provider.productDetail == null) {
            return const Center(
              child: Text('No product details available.'),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  provider.productDetail!.image,
                  height: 200,
                  width: double.infinity,
                ),
                const SizedBox(height: 16),
                Text(
                  provider.productDetail!.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${provider.productDetail!.price}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  provider.productDetail!.description,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
