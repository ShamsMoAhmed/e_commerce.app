// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:convert';

import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class product_screen extends StatefulWidget {
  const product_screen({Key? key}) : super(key: key);

  @override
  State<product_screen> createState() => _product_screenState();
}

class _product_screenState extends State<product_screen> {
  bool isloading = true;

  List<Product> product = [];

  getProduct() async {
    //to make request to get this data:
    var url = Uri.parse("https://fakestoreapi.com/products");

    // to avoid app stops when it request the data from server , using : try{ code}& catch(e){another code must be done if the code in try block is incorrect}
    try {
      var res = await http.get(url);
      var data = jsonDecode(res.body);
      for (var item in data) {
        // ignore: curly_braces_in_flow_control_structures
        var PR = Product(
            imageUrl: item["image"],
            price: item["price"],
            productTitle: item["title"]);
        product.add(PR);
      }
      setState(() {
        isloading = false;
        product;
      });
    } catch (e) {
      setState(() {
        isloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("This page can not load"),
        ),
      );
    }
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
                      item.imageUrl,
                      height: 250,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      item.price.toString() + " \$",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.red[400],
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      item.productTitle,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "More info",
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
