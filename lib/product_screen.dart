import 'package:flutter/material.dart';

import 'models/product_model.dart';
import 'product_details.dart';
import 'services/product_service.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool isLoading = true;

  List<Product> products = [];
  final productService = ProductServices();

  get_Product() async {
    try {
      var _prod = await productService.getProducts();

      setState(() {
        isLoading = false;
        products = _prod;
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
          itemCount: products.length,
          itemBuilder: ((context, index) {
            final item = products[index];
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
                            builder: (_) => ProductDetails(
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