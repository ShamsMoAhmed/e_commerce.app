// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/product_service.dart';
import 'package:flutter/material.dart';

import 'product_details.dart';

class product_screen extends StatefulWidget {
  const product_screen({Key? key}) : super(key: key);

  @override
  State<product_screen> createState() => _product_screenState();
}

class _product_screenState extends State<product_screen> {
  bool isLoading = true;

  List<Product> product = [];
  final productService = ProductServices();

  get_Product() async {
    try {
      var _prod = await productService.getProducts();

      setState(() {
        isLoading = false;
        product = _prod;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("This page can not load"),
        ));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_Product();
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
                    if (isLoading == true)
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    Image.network(
                      item.imageUrl,
                      height: 200,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      item.price.toString() + " \$",
                      style: TextStyle(
                          fontSize: 25,
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => product_details(
                              productId: item.Id,
                            ),
                          ),
                        );
                      },
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
