import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:estore/domain/models/models.dart';
import 'package:estore/providers/product_provider.dart';
import 'package:estore/utils/validators.dart';

class CreateUpdateProductScreen extends StatefulWidget {
  const CreateUpdateProductScreen({
    super.key,
    required this.create,
    this.product,
  }) : assert(
          (create == true && product == null) ||
              (create == false && product != null),
        );

  final bool create;
  final ProductModel? product;

  @override
  State<CreateUpdateProductScreen> createState() =>
      _CreateUpdateProductScreenState();
}

class _CreateUpdateProductScreenState extends State<CreateUpdateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (!widget.create && widget.product != null) {
      _titleController.text = widget.product!.title;
      _priceController.text = widget.product!.price;
      _categoryController.text = widget.product!.category;
      _descriptionController.text = widget.product!.description;
    }
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
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          padding: MediaQuery.of(context).viewInsets +
              const EdgeInsets.all(
                16.0,
              ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
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
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final product = ProductModel(
                        id: widget.create
                            ? DateTime.now().millisecondsSinceEpoch
                            : widget.product!.id,
                        title: _titleController.text.trim(),
                        price: _priceController.text.trim(),
                        category: _categoryController.text.trim(),
                        description: _descriptionController.text.trim(),
                      );

                      context.read<ProductProvider>().onButtonTapped(
                            create: widget.create,
                            product: product,
                          );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          duration: const Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String get title => '${widget.create ? 'Add' : 'Update'} a Product';
  String get message =>
      'Product ${widget.create ? 'created' : 'updated'} successfully';
}
