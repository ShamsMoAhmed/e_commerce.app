// ignore_for_file: prefer_const_constructors

import 'package:e_commerce_app/services/product_service.dart';
import 'package:flutter/material.dart';

import 'models/product_model.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({Key? key}) : super(key: key);

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  var titleController = TextEditingController();
  var priceController = TextEditingController();
  var descController = TextEditingController();

  bool isLoading = false;
  //To control the form and can modify on it:    this is like controller.
  var formKey = GlobalKey<FormState>();
  final productService = ProductServices();

  addProducts() async {
    setState(() {
      isLoading = true;
    });
    var isValid = formKey.currentState!.validate();
    if (isValid == false) return;

    var prod = AddProduct(
        title: titleController.text,
        price: num.parse(priceController.text),
        desc: descController.text,
        stock: 300,
        brand: "Apple");

    try {
      var isAdded = await productService.addProduct(prod);
      if (isAdded) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Product is added"),
          ),
        );
        titleController.clear();
        priceController.clear();
        descController.clear();
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error"),
          ),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Product can't be added"),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a Product"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (isLoading)
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: ((value) {
                        if (value == null) {
                          return "Please write title";
                        } else if (value.trim().isEmpty) {
                          return "title can not be empty";
                        } else {
                          return null;
                        }
                      }),
                      controller: titleController,
                      decoration: InputDecoration(
                        label: Text(
                          "title",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null) {
                          return "Please write the price";
                        } else if (value.trim().isEmpty) {
                          return "Price can not be empty";
                        }
                        num price = num.parse(value);
                        if (price <= 0) {
                          return "Price must be more than 1";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: priceController,
                      decoration: InputDecoration(
                        label: Text(
                          "price",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null) {
                          return "Please write the description";
                        } else if (value.trim().isEmpty) {
                          return "Desc can not be empty";
                        } else if (value.trim().length <= 10) {
                          return "this desc is too short";
                        } else {
                          return null;
                        }
                      },
                      controller: descController,
                      decoration: InputDecoration(
                        label: Text(
                          "description",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addProducts();
                      },
                      child: Text(
                        "add product",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
