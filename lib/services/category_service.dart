// lib/services/category_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../utils/utils.dart'; // Import the utils file

class CategoryService {
  final String apiUrl = '${APIUtils.baseUrl}/getCategory.php'; // Use APIUtils.baseUrl

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        return (data['result'] as List)
            .map((category) => Category.fromJson(category))
            .toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
