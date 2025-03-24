import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cart; // Nhận danh sách giỏ hàng

  const CartScreen({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ Hàng'),
        backgroundColor: Colors.black,
      ),
      body: cart.isEmpty
          ? Center(
        child: Text(
          "Giỏ hàng trống!",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final item = cart[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: ListTile(
              leading: Image.asset(
                "images/salad2.png", // Ảnh sản phẩm
                width: 50,
                fit: BoxFit.cover,
              ),
              title: Text(item["name"]),
              subtitle: Text("Số lượng: ${item["quantity"]}"),
              trailing: Text(
                "\$${item["price"]}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
