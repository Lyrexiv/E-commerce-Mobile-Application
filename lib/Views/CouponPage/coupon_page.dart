import 'package:flutter/material.dart';
import 'package:ecommerce_mobile_application/models/coupon_model.dart';
import 'package:ecommerce_mobile_application/services/coupon_service.dart';

class CouponPage extends StatefulWidget {
  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  late Future<List<Coupon>> _coupons;

  @override
  void initState() {
    super.initState();
    _coupons = CouponService().fetchCoupons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh Sách Mã Giảm Giá'),
        backgroundColor: Colors.blueAccent,
        elevation: 0, // Loại bỏ bóng đổ của AppBar
      ),
      body: Container(
        color: Colors.blueAccent[50], // Màu nền của danh sách mã giảm giá
        child: FutureBuilder<List<Coupon>>(
          future: _coupons,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Lỗi: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Không có mã giảm giá nào'));
            } else {
              final coupons = snapshot.data!;
              return ListView.separated(
                itemCount: coupons.length,
                separatorBuilder: (context, index) => SizedBox(height: 8.0), // Khoảng cách giữa các thẻ
                itemBuilder: (context, index) {
                  final coupon = coupons[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    elevation: 5.0, // Tăng độ bóng đổ của thẻ
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0), // Bo góc của thẻ
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      title: Text(
                        coupon.code,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent[800], // Màu chữ cho tiêu đề
                          fontSize: 18.0, // Kích thước chữ
                        ),
                      ),
                      subtitle: Text(
                        'Giảm giá: ${coupon.discount.toStringAsFixed(2)}%\nHết hạn: ${coupon.expirationDate.toLocal().toString().split(' ')[0]}',
                        style: TextStyle(
                          color: Colors.blueAccent[600], // Màu chữ cho phụ đề
                          fontSize: 16.0, // Kích thước chữ
                        ),
                      ),
                      trailing: Icon(
                        coupon.isActive ? Icons.check_circle : Icons.cancel,
                        color: coupon.isActive ? Colors.blueAccent : Colors.red,
                        size: 28.0, // Kích thước của icon
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
