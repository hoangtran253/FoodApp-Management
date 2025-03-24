import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:food_app/pages/home.dart';
import 'package:food_app/pages/order.dart'; // Import trang Order
import 'package:food_app/pages/profile.dart';
import 'package:food_app/pages/wallet.dart';
import 'package:food_app/providers/cart_provider.dart';

import 'cart_provider.dart'; // Import CartProvider

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final cartProvider =
        Provider.of<CartProvider>(context); // Lấy cartProvider từ Provider

    final List<Widget> pages = [
      const Home(),
      Order(cartItems: cartProvider.cartItems), // Truyền cartItems từ Provider
      const Wallet(),
      const Profile(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 60,
        backgroundColor: Colors.transparent,
        color: Colors.black,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.shopping_cart, color: Colors.white),
          Icon(Icons.wallet, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
      ),
    );
  }
}
