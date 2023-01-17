import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Product> products = [];

  addItem(Product prod) {
    products.add(prod);
    notifyListeners();
  }

  removeItem(Product prod) {
    products.remove(prod);
    notifyListeners();
  }
}
