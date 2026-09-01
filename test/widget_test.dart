import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/providers/auth_provider.dart';
import 'package:e_commerce/providers/cart_provider.dart';

void main() {
  group('E-Commerce App Smoke Tests', () {
    testWidgets('Initial route displays LoginPage with header and form fields', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => CartProvider()),
          ],
          child: const MyApp(),
        ),
      );

      // Verify that LoginPage renders new header text
      expect(find.text('Selamat Datang!'), findsOneWidget);
      expect(find.text('Masuk ke akun EcoGlobal kamu'), findsOneWidget);

      // Verify input fields and buttons
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Masuk'), findsOneWidget);
      expect(find.text("Belum punya akun? "), findsOneWidget);
      expect(find.text("Daftar"), findsOneWidget);
    });

    testWidgets('Empty login submission triggers validation errors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => CartProvider()),
          ],
          child: const MyApp(),
        ),
      );

      // Tap Masuk button with empty inputs
      await tester.tap(find.widgetWithText(ElevatedButton, 'Masuk'));
      await tester.pump();

      // Verify error messages
      expect(find.text('Email tidak boleh kosong'), findsOneWidget);
      expect(find.text('Password tidak boleh kosong'), findsOneWidget);
    });
  });

  group('CartProvider Unit Tests', () {
    test('Add item, increment, decrement, and compute total price', () {
      final cart = CartProvider();
      final initialCount = cart.items.length;

      const testProduct = Product(
        id: 'test-1',
        title: 'Test Sneaker',
        description: 'Test Description',
        price: 100.0,
        discountPercent: 20, // discounted price: 80.0
        imagePath: 'images/items/1.png',
      );

      // Add product
      cart.addToCart(testProduct);
      expect(cart.items.length, initialCount + 1);

      // Increment quantity
      cart.incrementQuantity('test-1');
      final item = cart.items.firstWhere((i) => i.product.id == 'test-1');
      expect(item.quantity, 2);
      expect(item.totalPrice, 160.0);

      // Decrement quantity
      cart.decrementQuantity('test-1');
      final updatedItem = cart.items.firstWhere((i) => i.product.id == 'test-1');
      expect(updatedItem.quantity, 1);

      // Remove product
      cart.removeFromCart('test-1');
      expect(cart.items.any((i) => i.product.id == 'test-1'), isFalse);
    });
  });

  group('AuthProvider Unit Tests', () {
    test('Login, register, and logout lifecycle', () async {
      final auth = AuthProvider();

      expect(auth.isAuthenticated, isTrue); // default mock user

      // Logout
      auth.logout();
      expect(auth.isAuthenticated, isFalse);
      expect(auth.user, isNull);

      // Login
      await auth.login('user@test.com', 'password123');
      expect(auth.isAuthenticated, isTrue);
      expect(auth.user?.email, 'user@test.com');

      // Register
      await auth.register('Jane Doe', 'jane@test.com', 'password123');
      expect(auth.user?.name, 'Jane Doe');
      expect(auth.user?.email, 'jane@test.com');
    });
  });
}
