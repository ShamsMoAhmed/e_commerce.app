import 'package:flutter/material.dart';

import 'home_screen.dart';

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
      print("please chech your pass or phoneNum");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "please write your phone number",
                  label: Text("phone number")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
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
              ),
            ],
          )
        ],
      ),
    ));
  }
}
