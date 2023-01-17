import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'models/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            for (var item in cart.products) Text(item.productTitle),
          ],
        ),
      ),
    );
  }
}
