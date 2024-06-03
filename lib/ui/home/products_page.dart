import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:estore/domain/blocs/blocs.dart';

import 'widgets/widgets.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().getProductsList();
  }

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
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state.getProductsListStatus == GetProductsListStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.productsList.isEmpty) {
              return Center(
                child: Text(
                  'No products available, yet.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            }
            return ListView.builder(
              itemCount: state.productsList.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: state.productsList[index],
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateProductBottomSheet(),
        tooltip: 'Add a Product',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateProductBottomSheet() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const CreateProductBottomSheet();
      },
    );
  }
}
