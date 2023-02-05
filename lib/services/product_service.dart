import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ProductServices {
  Future<List<Product>> getProducts() async {
    List<Product> products = [];

    //to make request to get this data:
    var url = Uri.parse("https://dummyjson.com/products");

    // to avoid app stops when it requests the data from server , using : try{ code}& catch(e){another code must be done if the code in try block is incorrect}

    var res = await http.get(url);
    var data = jsonDecode(res.body);
    for (var item in data["products"]) {
      // ["products"]: this word is added as in the new link of data there is ["products"] then the data is shown so i must write this word before.
      // ignore: curly_braces_in_flow_control_structures
      var pro = Product.fromJson(item);
      products.add(pro);
      // product: the empty list that I made before .
    }
    return products;
  }

// this time ,future will return <"Product "> not <list  <Product>>.
  Future<Product> getProductById(num id) async {
    var url = Uri.parse("https://dummyjson.com/products/$id");

    var res = await http.get(url);
    var data = jsonDecode(res.body);
    return Product.fromJson(data);
  }

  Future<bool> addProduct(Product newProduct) async {
    var url = Uri.parse("https://dummyjson.com/products/add");
    var data = newProduct.toJson();
    var encodedData = jsonEncode(data);
    var response = await http.post(url, body: encodedData);
    print(response.statusCode);
    return response.statusCode == 200;
  }
}
