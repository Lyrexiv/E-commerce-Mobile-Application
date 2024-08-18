class Coupon {

  final String code;
  final double discount;
  final DateTime expirationDate;
  final bool isActive;

  Coupon({
    required this.code,
    required this.discount,
    required this.expirationDate,
    required this.isActive,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    // Kiểm tra và đảm bảo các trường có kiểu dữ liệu đúng
    final code = json['code'] as String;
    final discount = (json['discount'] is num) ? (json['discount'] as num).toDouble() : double.tryParse(json['discount'].toString()) ?? 0.0;
    final expirationDate = DateTime.parse(json['expiration_date'] as String);
    final isActive = json['is_active'] is bool ? json['is_active'] as bool : json['is_active'] == 'true';

    return Coupon(
      code: code,
      discount: discount,
      expirationDate: expirationDate,
      isActive: isActive,
    );
  }
}
