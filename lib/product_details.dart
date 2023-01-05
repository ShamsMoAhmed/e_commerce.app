import 'dart:convert';

import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class product_details extends StatefulWidget {
  final int productId;
  const product_details({Key? key, required this.productId}) : super(key: key);

  @override
  State<product_details> createState() => _product_detailsState();
}

class _product_detailsState extends State<product_details> {
  bool isLoading = true;
  Product? details;
  getDetails() async {
    var url =
        Uri.parse("https://fakestoreapi.com/products/${widget.productId}");
    try {
      var res = await http.get(url);
      var data = jsonDecode(res.body);
      details = Product(
        imageUrl: data["image"],
        price: data["price"],
        productTitle: data["title"],
        Id: data["id"],
        description: data["description"],
      );

      setState(() {
        isLoading = false;
        details;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("this page can not load"),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Details")),
      body: SafeArea(
          child: ListView(
        children: [
          if (isLoading == true)
            Row(
              children: [
                CircularProgressIndicator(),
              ],
            ),
          if (details != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    Image.network(
                      details!.imageUrl,
                      height: 250,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      details!.price.toString() + " \$",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.red[400],
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      details!.description,
                      style: TextStyle(fontSize: 17, color: Colors.blue[900]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      details!.productTitle,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Add to cart",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      )),
    );
  }
}
