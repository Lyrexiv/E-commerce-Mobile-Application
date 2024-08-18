import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecommerce_mobile_application/utils/utils.dart';
import 'package:ecommerce_mobile_application/Models/user.dart';

class AuthAPI {
  Future<AuthResponse> login(User user) async {
    final response = await http.post(
      Uri.parse('${APIUtils.baseUrl}/Login.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    return AuthResponse.fromJson(json.decode(response.body));
  }

  Future<AuthResponse> register(User user) async {
    final response = await http.post(
      Uri.parse('${APIUtils.baseUrl}/Signup.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    // In ra mã trạng thái và phản hồi từ server để kiểm tra
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    // Kiểm tra nếu phản hồi không phải là JSON hợp lệ
    try {
      return AuthResponse.fromJson(json.decode(response.body));
    } catch (e) {
      print('Error decoding JSON: $e');
      throw FormatException('Unexpected response format');
    }
  }
}
