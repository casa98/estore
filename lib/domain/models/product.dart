import 'dart:convert';

class Product {
  final int? id;
  final String title;
  final String price;
  final String category;
  final String description;
  final String image;

  Product({
    this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      category: json['category'],
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'category': category,
        'description': description,
        'image': image,
      };
}

List<Product> listProductsFromJson(String str) => List<Product>.from(
      json.decode(str).map((x) => Product.fromJson(x)),
    );
