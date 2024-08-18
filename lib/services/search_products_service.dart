import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import '../utils/utils.dart';

class ProductService {
  final String apiUrl = '${APIUtils.baseUrl}/search_products.php';

  Future<List<Product>> searchProducts(String query) async {
    final response = await http.get(Uri.parse('$apiUrl?search=$query'));

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success']) {
          final List<dynamic> productsJson = data['result'];
          return productsJson.map((json) => Product.fromJson(json)).toList();
        } else {
          throw Exception('Failed to load products: ${data['message']}');
        }
      } catch (e) {
        throw Exception('Failed to parse JSON: $e');
      }
    } else {
      throw Exception('Failed to load products');
    }
  }
}
