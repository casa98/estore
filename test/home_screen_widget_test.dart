import 'package:estore/providers/product_provider.dart';
import 'package:estore/screens/home_screen.dart';
import 'package:estore/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  group('Managing products', () {
    testWidgets('List products initial state', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Products'), findsOneWidget);
      expect(find.text('No products available, yet.'), findsOneWidget);
    });

    testWidgets('Add a product', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      expect(find.byType(FloatingActionButton), findsOneWidget);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.text('Add a Product'), findsOne);
      expect(find.text('Submit'), findsOne);
      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.text('Title 1'), findsNothing);

      await tester.enterText(find.byType(TextFormField).at(0), 'Title 1');
      await tester.enterText(find.byType(TextFormField).at(1), '23.3');
      await tester.enterText(find.byType(TextFormField).at(2), 'Category 1');
      await tester.enterText(find.byType(TextFormField).at(3), 'Description 1');

      expect(find.text('Title 1'), findsOneWidget);

      // Tap the Submit button to add product
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      // Verify product was added to state
      final productProvider =
          tester.state(find.byType(HomeScreen)).context.read<ProductProvider>();

      expect(productProvider.products.length, 1);
      expect(productProvider.products.first.title, 'Title 1');

      // App should be back in HomeScreen
      expect(find.text('Products'), findsOneWidget);
      expect(find.byType(ProductCard), findsOneWidget);

      // Go view product details
      await tester.tap(find.byType(ProductCard));
      await tester.pumpAndSettle();

      expect(find.text('Title 1'), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is IconButton && widget.tooltip == 'Edit a product',
        ),
        findsOneWidget,
      );
    });
  });
}
