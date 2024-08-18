class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final priceValue = json['price'];
    final price = double.tryParse(priceValue.toString()) ?? 0.0;

    return Product(
      id: int.tryParse(json['product_id'].toString()) ?? 0,
      name: json['name'],
      price: price,
      imageUrl: json['image_url'],
      description: json['description'],
    );
  }
}
