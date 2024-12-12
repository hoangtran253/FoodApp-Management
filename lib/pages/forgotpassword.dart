import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/pages/signup.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController mailcontroller = new TextEditingController();

  String email = "";
  final _formkey = GlobalKey<FormState>();

  resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: mailcontroller.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        'Password Reset Email has been sent!',
        style: TextStyle(color: Colors.white, fontSize: 18),
      )));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          content: Text(
            'No User Found for that Email',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          backgroundColor: Colors.red,
        )));
      }
      print("Error: ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 70),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Password Recovery',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Enter your email',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Expanded(
              child: Form(
                  key: _formkey,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white70, width: 2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextFormField(
                            controller: mailcontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Email';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                    fontSize: 18, color: Colors.white),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white70,
                                  size: 30,
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                email = mailcontroller.text;
                              });
                            }
                            resetPassword();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shadowColor: Colors.white,
                            elevation: 10,
                            fixedSize: Size(100, 50),
                          ),
                          child: Text(
                            'Send Email',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have a account? ",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()),
                                );
                              },
                              child: Text(
                                'Create',
                                style: TextStyle(
                                    color: Colors.amberAccent,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

//resetpass
// <p>Xin chào,</p>
// <p>
// Bạn đã yêu cầu đặt lại mật khẩu cho tài khoản Food App của mình, được liên kết với địa chỉ email: %EMAIL%.</p>
//
// <p>Vui lòng nhấn vào liên kết dưới đây để đặt lại mật khẩu mới:</p>
// <p><a href='%LINK%'>%LINK%</a></p>
// <p>Nếu bạn không yêu cầu đặt lại mật khẩu, hãy bỏ qua email này. Tài khoản của bạn sẽ không bị thay đổi.</p>
// <p>Cảm ơn bạn đã sử dụng Food App.</p>
// <p>Trân trọng,</p>
// <p>Đội ngũ hỗ trợ Food App</p>
