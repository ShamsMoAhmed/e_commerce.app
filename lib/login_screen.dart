// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'product_screen.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  login() {
    var phone = phoneNumberController.text;
    var pass = passwordController.text;
    if (phone == "123456" && pass == "12300") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductScreen(),
          ));
    } else
      // ignore: curly_braces_in_flow_control_structures
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Your phone number or pass is incorrect"),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Image.asset(
              "assets/images/login_logo.png",
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.phone,
                controller: phoneNumberController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(
                      Icons.phone,
                      size: 30,
                    ),
                    hintText: "please write your phone number",
                    label: Text("phone number")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(
                      Icons.lock,
                      size: 30,
                    ),
                    hintText: "please write your Password",
                    label: Text("Password")),
              ),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    login();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("hello"),
                      ),
                    );
                  },
                  child: Text("login"),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Text("Create an account"),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
