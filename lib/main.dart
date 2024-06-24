import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/product_provider.dart';
import 'repositories/product_repository_impl.dart';
import 'screens/category_list_screen.dart';
import 'screens/product_list_screen.dart';
import 'services/product_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductProvider(ProductRepositoryImpl(ProductService())),
      child: MaterialApp(
        title: 'Estore',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(centerTitle: true),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Estore'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Products'),
              Tab(text: 'Categories'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ProductListScreen(),
            CategoryListScreen(),
          ],
        ),
      ),
    );
  }
}
