class ProductModel {
  final int id;
  final String title;
  final num price;
  final String category;
  final String description;
  final String image;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      category: json['category'],
      description: json['description'],
      image: json['image'],
    );
  }

  String _truncateDescription(String description, {int maxLength = 50}) {
    return description.length <= maxLength
        ? description
        : '${description.substring(0, maxLength)}...';
  }

  @override
  String toString() {
    return '''
Product ID: $id
Title: $title
Price: \$$price
Category: $category
Description: ${_truncateDescription(description)}
----------------------
''';
  }
}
