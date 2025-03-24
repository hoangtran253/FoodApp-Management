import 'package:flutter/material.dart';
import 'package:food_app/pages/order.dart';
import 'package:provider/provider.dart';
import 'package:food_app/widget/widget_support.dart';
import 'package:food_app/pages/details.dart';
import 'package:food_app/providers/cart_provider.dart';

import 'cart_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false, burger = false, salad = false, pizza = false;

  final List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "Vegetable Salad",
      "price": 25.0,
      "image": "images/salad2.png",
      "description": "Fresh and Healthy",
      "category": "salad"
    },
    {
      "id": 2,
      "name": "MixVeg Salad",
      "price": 28.0,
      "image": "images/salad2.png",
      "description": "Spicy with Onion",
      "category": "salad"
    },
    {
      "id": 3,
      "name": "Mediterranean Salad",
      "price": 28.0,
      "image": "images/salad2.png",
      "description": "Honey goat cheese",
      "category": "salad"
    }
  ];

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header với số lượng sản phẩm trong giỏ
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hello DHoang,", style: AppWidget.boldTextFieldStyle()),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Order(cartItems: cartProvider.cartItems),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          const Icon(Icons.shopping_cart_outlined,
                              color: Colors.white),
                          if (cartProvider.cartItems.isNotEmpty)
                            Positioned(
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  cartProvider.cartItems.length.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Text("Delicious Food", style: AppWidget.HeadlineTextFieldStyle()),
              Text("Discover and Get Great Food",
                  style: AppWidget.LineTextFieldStyle()),
              const SizedBox(height: 20.0),

              // Phần categories với filter
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: showItem(),
              ),
              const SizedBox(height: 30.0),

              // Danh sách sản phẩm ngang
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: products
                      .where((p) => salad ? p["category"] == "salad" : true)
                      .map((product) => _buildProductCard(context, product))
                      .toList(),
                ),
              ),

              // Sản phẩm nổi bật
              Container(
                margin: const EdgeInsets.all(20),
                child: _buildFeaturedProduct(context, products[2]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(product: product),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  product["image"],
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
                Text(product["name"],
                    style: AppWidget.HeadlineTextFieldStyle()),
                const SizedBox(height: 5),
                Text(product["description"],
                    style: AppWidget.LineTextFieldStyle()),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$${product["price"]}",
                        style: AppWidget.HeadlineTextFieldStyle()),
                    IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        cartProvider.addToCart({
                          "id": product["id"],
                          "name": product["name"],
                          "price": product["price"],
                          "image": product["image"],
                          "quantity": 1,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added ${product["name"]} to cart'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedProduct(
      BuildContext context, Map<String, dynamic> product) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(product: product),
          ),
        );
      },
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                product["image"],
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product["name"],
                      style: AppWidget.HeadlineTextFieldStyle(),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      product["description"],
                      style: AppWidget.LineTextFieldStyle(),
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${product["price"]}",
                          style: AppWidget.HeadlineTextFieldStyle(),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            cartProvider.addToCart({
                              "id": product["id"],
                              "name": product["name"],
                              "price": product["price"],
                              "image": product["image"],
                              "quantity": 1,
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Added ${product["name"]} to cart'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCategoryButton(
          icon: 'images/ice-cream.png',
          isSelected: icecream,
          onTap: () => setState(() {
            icecream = true;
            pizza = false;
            salad = false;
            burger = false;
          }),
        ),
        _buildCategoryButton(
          icon: 'images/burger.png',
          isSelected: burger,
          onTap: () => setState(() {
            burger = true;
            pizza = false;
            salad = false;
            icecream = false;
          }),
        ),
        _buildCategoryButton(
          icon: 'images/salad.png',
          isSelected: salad,
          onTap: () => setState(() {
            salad = true;
            pizza = false;
            icecream = false;
            burger = false;
          }),
        ),
        _buildCategoryButton(
          icon: 'images/pizza.png',
          isSelected: pizza,
          onTap: () => setState(() {
            pizza = true;
            icecream = false;
            salad = false;
            burger = false;
          }),
        ),
      ],
    );
  }

  Widget _buildCategoryButton({
    required String icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(10),
          child: Image.asset(
            icon,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
