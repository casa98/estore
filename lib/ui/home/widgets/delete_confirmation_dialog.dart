import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  const DeleteConfirmationDialog({
    super.key,
    required this.onDelete,
  });

  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Delete Product'),
      content: const Text('Are you sure you want to delete this product?'),
      actions: Platform.isIOS
          ? [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: onDelete,
                child: const Text('Yes'),
              ),
            ]
          : [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: onDelete,
                child: const Text('Yes'),
              ),
            ],
    );
  }
}
