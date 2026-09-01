import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'providers/chat_provider.dart';
import 'models/chat_contact.dart';
import 'theme/app_theme.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/account_page.dart';
import 'pages/cart_page.dart';
import 'pages/home_page.dart';
import 'pages/list_chat.dart';
import 'pages/detail_chat.dart';
import 'pages/change_password_page.dart';
import 'pages/checkout_page.dart';
import 'pages/order_success_page.dart';
import 'pages/order_history_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoGlobal E-Commerce',
      theme: AppTheme.theme,
      initialRoute: 'HomePage',
      routes: {
        'LoginPage': (context) => const LoginPage(),
        'RegisterPage': (context) => const RegisterPage(),
        'AccountPage': (context) => const AccountPage(),
        '/accountPage': (context) => const AccountPage(),
        'ChangePasswordPage': (context) => const ChangePasswordPage(),
        'CartPage': (context) => const CartPage(),
        'HomePage': (context) => const HomePage(),
        'ListChat': (context) => ChatListPage(),
        'ChatDetail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          if (args is ChatContact) {
            return ChatScreen(contact: args);
          }
          return ChatScreen(contact: ChatContact(id: 'nike', name: 'Nike Official', avatar: 'images/1.png'));
        },
        'CheckoutPage': (context) => const CheckoutPage(),
        'OrderSuccess': (context) => const OrderSuccessPage(),
        'OrderHistoryPage': (context) => const OrderHistoryPage(),
        'itemsPage': (context) => const _PlaceholderPage(title: 'Product Detail'),
        '/notifications': (context) => const _PlaceholderPage(title: 'Notifications'),
        '/help': (context) => const _PlaceholderPage(title: 'Help & Support'),
      },
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  final String title;
  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title, style: const TextStyle(color: Colors.white)), backgroundColor: AppTheme.primary),
      body: Center(child: Text('$title\n(Coming Soon)', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primary))),
    );
  }
}
