import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:estore/data/repositories/product/local_product_repository_impl.dart';
import 'package:estore/domain/blocs/products/product_bloc.dart';
import 'package:estore/ui/home/products_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductCubit(LocalProductRepositoryImpl()),
      child: MaterialApp(
        title: 'Estore',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(centerTitle: true),
        ),
        home: const ProductsPage(),
      ),
    );
  }
}
