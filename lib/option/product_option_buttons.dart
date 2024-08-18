import 'package:flutter/material.dart';
import 'package:ecommerce_mobile_application/services/cart_service.dart'; // Import CartAPI

class ProductOptionButtons extends StatelessWidget {
  final int userId;
  final int productId;
  final String productName; // Thêm productName
  final double price;
  const ProductOptionButtons({Key? key, required this.userId, required this.productId, required this.productName, required this.price}) : super(key: key);

  Future<void> _handleAddToCart(BuildContext context) async {
    final cartAPI = CartAPI(); // Tạo một thể hiện của CartAPI

    try {
      bool success = await cartAPI.addToCart(userId, productId, 1, productName, price); // Ví dụ với quantity = 1
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sản phẩm đã được thêm vào giỏ hàng')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thêm vào giỏ hàng thất bại')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => _handleAddToCart(context),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            child: const Text('Thêm vào giỏ'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Xử lý nút Mua ngay
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: const Text('Mua ngay'),
          ),
        ),
      ],
    );
  }
}
