import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/account_page.dart';
import 'pages/cart_page.dart';
import 'pages/home_page.dart';
import 'pages/list_chat.dart';
import 'pages/detail_chat.dart';
import 'pages/register_page.dart'; // Impor RegisterPage baru

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'LoginPage',
      routes: {
        'LoginPage': (context) => const LoginPage(),
        'RegisterPage': (context) => const RegisterPage(), // Daftarkan rute RegisterPage
        'AccountPage': (context) => const AccountPage(),
        'CartPage': (context) => const CartPage(),
        'HomePage': (context) => const HomePage(),
        'ListChat': (context) => ChatListPage(),
        'ChatDetail': (context) => ChatScreen(contactName: 'Nike Official'),
      },
    );
  }
}