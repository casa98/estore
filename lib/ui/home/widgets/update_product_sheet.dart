import 'package:estore/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:estore/domain/blocs/products/product_bloc.dart';
import 'package:estore/domain/models/product.dart';

class UpdateProductBottomSheet extends StatefulWidget {
  const UpdateProductBottomSheet({super.key, required this.product});

  final Product product;

  @override
  State<UpdateProductBottomSheet> createState() =>
      _UpdateProductBottomSheetState();
}

class _UpdateProductBottomSheetState extends State<UpdateProductBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _priceController;
  late final TextEditingController _categoryController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.product.title);
    _priceController = TextEditingController(text: widget.product.price);
    _categoryController = TextEditingController(text: widget.product.category);
    _descriptionController = TextEditingController(
      text: widget.product.description,
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: MediaQuery.of(context).viewInsets + const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Update a Product',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _titleController,
              decoration: _inputDecoration('Title'),
              textInputAction: TextInputAction.next,
              validator: Validators.validateEmpty,
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: _priceController,
              decoration: _inputDecoration('Price'),
              textInputAction: TextInputAction.next,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: Validators.validateNumberWithPossibleDecimal,
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: _categoryController,
              decoration: _inputDecoration('Category'),
              textInputAction: TextInputAction.next,
              validator: Validators.validateEmpty,
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: _descriptionController,
              decoration: _inputDecoration('Description'),
              maxLines: 3,
              validator: Validators.validateEmpty,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final product = Product(
                    id: widget.product.id,
                    title: _titleController.text.trim(),
                    price: _priceController.text.trim(),
                    category: _categoryController.text.trim(),
                    description: _descriptionController.text.trim(),
                    image: widget.product.image,
                  );
                  context.read<ProductCubit>().updateProduct(product: product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Product edited successfully'),
                      duration: Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  while (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
