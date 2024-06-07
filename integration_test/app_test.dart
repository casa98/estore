import 'package:estore/providers/product_provider.dart';
import 'package:estore/ui/home/create_update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Create product', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ProductProvider(),
        child: const MaterialApp(
          home: CreateUpdateProductScreen(
            create: true,
          ),
        ),
      ),
    );

    expect(find.byType(TextFormField), findsNWidgets(4));

    await tester.enterText(find.byType(TextFormField).at(0), 'Title 1');
    await Future.delayed(const Duration(seconds: 1));
    await tester.enterText(find.byType(TextFormField).at(1), '23.3');
    await Future.delayed(const Duration(seconds: 1));
    await tester.enterText(find.byType(TextFormField).at(2), 'Category 1');
    await Future.delayed(const Duration(seconds: 1));
    await tester.enterText(find.byType(TextFormField).at(3), 'Description 1');
    await Future.delayed(const Duration(seconds: 1));
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();
    //TODO: Complete exercise
  });
}
