import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_product_model.dart'; // Import model
import '../utils/utils.dart'; // Import utils

class CartAPI {
  Future<List<CartProductModel>> fetchCartProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('user_id'); // Lấy user_id kiểu int

    if (userId == null) {
      throw Exception('No user_id found');
    }

    final response = await http.post(
      Uri.parse('${APIUtils.baseUrl}/getCart.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'user_id': userId}), // Truyền user_id kiểu int
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      // Kiểm tra nếu success là chuỗi "success"
      if (responseData['status'] == 'success') {
        return (responseData['data'] as List)
            .map((data) => CartProductModel.fromJson(data))
            .toList();
      } else {
        throw Exception(responseData['message'] ?? 'Failed to load cart products');
      }
    } else {
      throw Exception('Failed to load cart products');
    }
  }

  Future<bool> addToCart(int userId, int productId, int quantity, String productName, double price) async {
    final response = await http.post(
      Uri.parse('${APIUtils.baseUrl}/add_to_cart.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'user_id': userId,
        'product_id': productId,
        'quantity': quantity,
        'product_name': productName,
        'price': price,
      }),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['status'] == 'success';
    } else {
      throw Exception('Failed to add product to cart');
    }
  }

}
