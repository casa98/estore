import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:estore/domain/blocs/products/product_bloc.dart';
import 'package:estore/domain/models/models.dart';
import 'package:estore/utils/validators.dart';

class CreateProductBottomSheet extends StatefulWidget {
  const CreateProductBottomSheet({super.key});

  @override
  State<CreateProductBottomSheet> createState() =>
      _CreateProductBottomSheetState();
}

class _CreateProductBottomSheetState extends State<CreateProductBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
              'Create a Product',
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
                    title: _titleController.text.trim(),
                    price: _priceController.text.trim(),
                    category: _categoryController.text.trim(),
                    description: _descriptionController.text.trim(),
                    image: '',
                  );
                  context.read<ProductCubit>().createProduct(product: product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Product created successfully'),
                      duration: Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
