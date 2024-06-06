import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:estore/providers/product_provider.dart';
import 'create_update_product_screen.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Consumer<ProductProvider>(
          builder: (context, provider, child) {
            if (provider.products.isEmpty) {
              return Center(
                child: Text(
                  'No products available, yet.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            }
            final products = provider.products.reversed.toList();
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: products[index],
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return const CreateUpdateProductScreen(
                  create: true,
                );
              },
            ),
          );
        },
        tooltip: 'Add a Product',
        child: const Icon(Icons.add),
      ),
    );
  }
}
