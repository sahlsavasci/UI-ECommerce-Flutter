import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/providers/auth_provider.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/order_provider.dart';

void main() {
  group('E-Commerce App Smoke Tests', () {
    testWidgets('Initial route displays HomePage with navigation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => CartProvider()),
            ChangeNotifierProvider(create: (_) => OrderProvider()),
          ],
          child: const MyApp(),
        ),
      );

      // Verify HomePage renders
      expect(find.text('Lower Shelf'), findsOneWidget);
      expect(find.text('Produk Terlaris'), findsOneWidget);
    });

    testWidgets('HomePage displays products and search bar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => CartProvider()),
            ChangeNotifierProvider(create: (_) => OrderProvider()),
          ],
          child: const MyApp(),
        ),
      );

      // Verify HomePage content
      expect(find.text('Lower Shelf'), findsOneWidget);
      expect(find.text('Produk Terlaris'), findsOneWidget);
      expect(find.text('Search Products'), findsOneWidget);
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
