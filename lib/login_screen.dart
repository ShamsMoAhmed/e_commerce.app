import 'package:flutter/material.dart';

import 'homeScreen.dart';

class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  login() {
    var phone = phoneNumberController.text;
    var pass = passwordController.text;
    if (phone == "123456" && pass == "12300") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home_screen(),
          ));
    } else
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets\images\login_logo.png"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
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
                },
                child: Text("login"),
              )
            ],
          )
        ],
      ),
    ));
  }
}
