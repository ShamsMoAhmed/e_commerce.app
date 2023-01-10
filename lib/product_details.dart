

import 'package:flutter/material.dart';

import 'models/product_model.dart';
import 'services/product_service.dart';

class ProductDetails extends StatefulWidget {
final int productId;
  const ProductDetails({Key? key, required this.productId}) : super(key: key);
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isLoading = true;
  Product? details;
  final productServices = ProductServices();
  getDetails() async {
    try {
      var _prods = await productServices.getProductById(widget.productId);

      setState(() {
        isLoading = false;
        details = _prods;
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
                      height: 200,
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
