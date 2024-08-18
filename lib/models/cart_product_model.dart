class CartProductModel {
  final String name;
  final double price;
  final int quantity;
  final double total; // Thêm trường total

  CartProductModel({
    required this.name,
    required this.price,
    required this.quantity,
    required this.total, // Thêm tham số total vào constructor
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    // Xử lý giá và số lượng
    String priceString = json['price']?.toString() ?? '0';
    String quantityString = json['quantity']?.toString() ?? '0';

    // Loại bỏ dấu phân cách hàng nghìn nếu có
    priceString = priceString.replaceAll(',', '');
    quantityString = quantityString.replaceAll(',', '');

    // Tính tổng giá trị
    double price = double.tryParse(priceString) ?? 0.0;
    int quantity = int.tryParse(quantityString) ?? 0;
    double total = price * quantity;

    return CartProductModel(
      name: json['product_name'] ?? '',
      price: price,
      quantity: quantity,
      total: total, // Gán giá trị total
    );
  }
}
