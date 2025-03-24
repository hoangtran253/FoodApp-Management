import 'package:flutter/material.dart';
import 'package:food_app/widget/widget_support.dart';
import 'order.dart'; // Import trang Order

class Details extends StatefulWidget {
  final Map<String, dynamic> product; // Thêm tham số product

  const Details({super.key, required this.product}); // Thêm required product

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  List<Map<String, dynamic>> cartItems = []; // Danh sách giỏ hàng

  void addToCart() {
    // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
    bool exists = false;
    for (var item in cartItems) {
      if (item["name"] == widget.product["name"]) {
        setState(() {
          item["quantity"] += quantity;
        });
        exists = true;
        break;
      }
    }

    // Nếu sản phẩm chưa có trong giỏ hàng thì thêm mới
    if (!exists) {
      setState(() {
        cartItems.add({
          "name": widget.product["name"],
          "price": widget.product["price"] ?? 28.0, // Giá mặc định nếu không có
          "image": widget.product["image"] ?? "images/salad2.png",
          "quantity": quantity,
        });
      });
    }

    // Hiển thị thông báo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Đã thêm ${widget.product["name"]} vào giỏ hàng"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                ),
              ),
              Image.asset(
                widget.product["image"] ?? "images/salad2.png",
                fit: BoxFit.cover,
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mediterran",
                        style: AppWidget.semiBoldTextFieldStyle(),
                      ),
                      Text(
                        widget.product["name"] ?? "Chick Salad",
                        style: AppWidget.boldTextFieldStyle(),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      if (quantity > 1) {
                        setState(() {
                          quantity--;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8)),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Text(quantity.toString()),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8)),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
                style: AppWidget.LineTextFieldStyle(),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Delivery Time',
                    style: AppWidget.semiBoldTextFieldStyle(),
                  ),
                  SizedBox(width: 50),
                  Icon(
                    Icons.alarm,
                    color: Colors.black,
                  ),
                  SizedBox(width: 10),
                  Text(
                    '30 min',
                    style: AppWidget.semiBoldTextFieldStyle(),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 50, bottom: 20),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Total Price',
                          style: AppWidget.semiBoldTextFieldStyle(),
                        ),
                        Text(
                          '\$${(widget.product["price"] ?? 28.0) * quantity}',
                          style: AppWidget.HeadlineTextFieldStyle(),
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: addToCart, // Thêm sự kiện khi nhấn nút
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Add to cart',
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Poppins'),
                            ),
                            SizedBox(width: 40),
                            GestureDetector(
                              onTap: () {
                                // Khi nhấn icon giỏ hàng thì chuyển sang trang Order
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Order(cartItems: cartItems),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
