import 'package:flutter/material.dart';
import 'package:food_app/widget/widget_support.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1;
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
                "images/salad2.png",
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
                        "Chick Salad",
                        style: AppWidget.boldTextFieldStyle(),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      if (a > 1) {
                        --a;
                      }
                      setState(() {});
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
                    child: Text(a.toString()),
                  ),
                  GestureDetector(
                    onTap: () {
                      ++a;
                      setState(() {});
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
                          '\$28',
                          style: AppWidget.HeadlineTextFieldStyle(),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
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
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                            ),
                          )
                        ],
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
