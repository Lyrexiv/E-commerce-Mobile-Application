import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import '../utils/utils.dart'; // Đảm bảo đường dẫn đúng đến APIUtils

class ProductService {
  final String apiUrl = '${APIUtils.baseUrl}/product.php';

  // Lấy danh sách sản phẩm theo categoryId
  Future<List<Product>> fetchProducts(int categoryId) async {
    final url = Uri.parse('$apiUrl?category_id=$categoryId');

    try {
      final response = await http.get(url);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}'); // In ra phản hồi để kiểm tra

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['success']) {
          final List<dynamic> productsJson = data['result'];
          return productsJson
              .map((product) => Product.fromJson(product))
              .toList();
        } else {
          throw Exception('Không thể tải sản phẩm: ${data['message']}');
        }
      } else {
        throw Exception('Lỗi máy chủ: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi khi lấy sản phẩm: $e');
    }
  }

  // Lấy tất cả sản phẩm
  Future<List<Product>> getAllProducts() async {
    final url = Uri.parse('${APIUtils.baseUrl}/get_all_products.php');

    try {
      final response = await http.get(url);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}'); // In ra phản hồi để kiểm tra

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['success']) {
          final List<dynamic> productsJson = data['products'];
          return productsJson
              .map((product) => Product.fromJson(product))
              .toList();
        } else {
          throw Exception('Không có sản phẩm nào');
        }
      } else {
        throw Exception('Lỗi máy chủ: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi khi lấy tất cả sản phẩm: $e');
    }
  }
}
