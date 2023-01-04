// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'cart_screen.dart';

class product_screen extends StatefulWidget {
  const product_screen({Key? key}) : super(key: key);

  @override
  State<product_screen> createState() => _product_screenState();
}

class _product_screenState extends State<product_screen> {
  bool isloading = true;
  List product = [];

  getProduct() async {
    //to make request to get this data:
    var url = Uri.parse("https://fakestoreapi.com/products");
    var res = await http.get(url);
    var data = jsonDecode(res.body);

    setState(() {
      isloading = false;
      product = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.edit),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      bottomNavigationBar: BottomNavigationBar(
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_rounded), label: "Cart"),
        ],
      ),
      appBar: AppBar(
        title: Text(
          "Products",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: product.length,
          itemBuilder: ((context, index) {
            final item = product[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    Image.network(
                      item["image"],
                      height: 250,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      item["price"].toString() + " \$",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.red[400],
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      item["title"],
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => cart_screen()),
                        );
                      },
                      child: Text(
                        "Add to cart",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
