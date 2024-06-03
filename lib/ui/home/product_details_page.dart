import 'package:estore/domain/models/models.dart';
import 'package:estore/ui/home/widgets/delete_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:estore/domain/blocs/products/product_bloc.dart';
import 'package:estore/domain/models/product.dart';

import 'widgets/widgets.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _showUpdateProductBottomSheet(context),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget.product.image,
                  ),
                  fit: BoxFit.cover,
                ),
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
                      if (widget.product.id != null) {
                        _showDeleteConfirmationDialog(
                          context,
                          product: widget.product,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showUpdateProductBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return UpdateProductBottomSheet(product: widget.product);
      },
    );
  }

  void _showDeleteConfirmationDialog(
    BuildContext context, {
    required Product product,
  }) async {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return DeleteConfirmationDialog(
          onDelete: () {
            context
                .read<ProductCubit>()
                .deleteProduct(productId: widget.product.id!);
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
