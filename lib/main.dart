// ignore_for_file: prefer_const_constructors

import 'package:e_commerce_app/cart_screen.dart';
import 'package:e_commerce_app/models/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: CartProvider(),
        ),
      ],
      child: MaterialApp(
        home: loginScreen(),
      ),
    ),
  );
}
