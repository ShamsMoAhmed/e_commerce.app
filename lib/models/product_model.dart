class Product {
  final String imageUrl;
  final String productTitle;
  final num price;
  final int id;
  final String description;

  Product(
      //constructor
      {
    required this.imageUrl,
    required this.price,
    required this.productTitle,
    required this.id,
    required this.description,
  });
}

class AddProduct {
  final String title;
  final num price;
  final num stock;
  final String brand;
  final String desc;

  AddProduct({
    required this.title,
    required this.price,
    required this.desc,
    required this.stock,
    required this.brand,
  });
}
