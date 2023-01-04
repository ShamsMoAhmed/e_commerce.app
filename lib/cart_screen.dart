// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class cart_screen extends StatefulWidget {
  const cart_screen({Key? key}) : super(key: key);

  @override
  State<cart_screen> createState() => _cart_screenState();
}

class _cart_screenState extends State<cart_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: SafeArea(
        child: Text("product added , Thank you for visiting"),
      ),
    );
  }
}
