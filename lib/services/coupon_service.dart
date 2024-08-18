import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/coupon_model.dart';
import '../utils/utils.dart';

class CouponService {
  final String apiUrl = '${APIUtils.baseUrl}/coupons.php'; // Đổi đường dẫn cho đúng

  Future<List<Coupon>> fetchCoupons() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success']) {
          final List<dynamic> couponsJson = data['result'];
          return couponsJson.map((json) => Coupon.fromJson(json)).toList();
        } else {
          throw Exception('Failed to load coupons: ${data['message']}');
        }
      } catch (e) {
        throw Exception('Failed to parse JSON: $e');
      }
    } else {
      throw Exception('Failed to load coupons');
    }
  }
}
