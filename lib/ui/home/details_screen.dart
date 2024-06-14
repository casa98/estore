import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:estore/domain/models/models.dart';
import 'package:estore/providers/product_provider.dart';

import 'create_update_product_screen.dart';
import 'widgets/widgets.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return CreateUpdateProductScreen(
                      create: false,
                      product: widget.product,
                    );
                  },
                ),
              );
            },
            tooltip: 'Edit a product',
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: FlutterLogo(
                size: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12.0),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      child: Text(widget.product.category),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(widget.product.description),
                  const SizedBox(height: 12.0),
                  TextButton.icon(
                    icon: const Icon(Icons.delete_forever_rounded),
                    label: const Text('Remove Product'),
                    onPressed: () {
                      _showDeleteConfirmationDialog(
                        context,
                        product: widget.product,
                      );
                    },
                  ),
                  const SizedBox(height: 12.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(
    BuildContext context, {
    required ProductModel product,
  }) async {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return DeleteConfirmationDialog(
          onDelete: () {
            context.read<ProductProvider>().deleteProduct(widget.product.id);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Product deleted successfully'),
                duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
              ),
            );
            while (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }
}
