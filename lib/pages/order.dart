import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';

class Order extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const Order({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ hàng (${cartItems.length})"),
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => cartProvider.clearCart(),
            )
        ],
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text("Giỏ hàng trống"))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Dismissible(
                  key: Key(item['name']),
                  onDismissed: (direction) {
                    cartProvider.removeItem(index);
                  },
                  child: Card(
                    child: ListTile(
                      leading:
                          Image.asset(item['image'], width: 50, height: 50),
                      title: Text(item['name']),
                      subtitle: Text("Số lượng: ${item['quantity']}"),
                      trailing: Text("\$${item['price'] * item['quantity']}"),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
