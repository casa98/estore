import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider = context.read<ProductProvider>();
      if (productProvider.categories.isEmpty) {
        context.read<ProductProvider>().getCategories();
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
          if (provider.categories.isEmpty) {
            return const Center(
              child: Text('No categories available.'),
            );
          }
          return ListView.builder(
            itemCount: provider.categories.length,
            itemBuilder: (context, index) {
              final category = provider.categories[index];
              return ListTile(
                title: Text(category.name),
              );
            },
          );
        },
      ),
    );
  }
}
