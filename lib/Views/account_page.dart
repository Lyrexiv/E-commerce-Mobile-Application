import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_mobile_application/Views/ShopingCartPage/ShoppingCart.dart';
import 'package:ecommerce_mobile_application/Views/SettingPage/SettingPage.dart';
import 'package:ecommerce_mobile_application/Views/Login&Register/Login/Login_Page.dart';
import 'package:ecommerce_mobile_application/main.dart';
import '../option/account_option.dart';
class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _isLoggedIn = false;
  String _username = '';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      _username = prefs.getString('username') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tài khoản'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingCart()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Chào mừng bạn đến với LyReXiV!',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _isLoggedIn ? _buildUserInfo() : _buildLoginButton(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dịch vụ nổi bật',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: buildFeaturedService(
                    icon: Icons.local_offer,
                    color: Colors.purpleAccent,
                    title: 'Astra',
                    action: () {
                      // Navigate to Astra page
                    },
                  ),
                ),
                Expanded(
                  child: buildFeaturedService(
                    icon: Icons.monetization_on,
                    color: Colors.yellowAccent,
                    title: 'Xu',
                    action: () {
                      // Navigate to Tiki Xu page
                    },
                  ),
                ),
                Expanded(
                  child: buildFeaturedService(
                    icon: Icons.percent,
                    color: Colors.lightBlueAccent,
                    title: 'Mã giảm giá',
                    action: () {
                      // Navigate to Mã giảm giá page
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Đơn hàng của tôi',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildOrderButton(
                    icon: Icons.shopping_cart,
                    title: 'Chờ thanh toán',
                    action: () {
                      // Navigate to Chờ thanh toán page
                    },
                  ),
                  buildOrderButton(
                    icon: Icons.delivery_dining,
                    title: 'Đang xử lý',
                    action: () {
                      // Navigate to Đang xử lý page
                    },
                  ),
                  buildOrderButton(
                    icon: Icons.delivery_dining,
                    title: 'Đang vận chuyển',
                    action: () {
                      // Navigate to Đang vận chuyển page
                    },
                  ),
                  buildOrderButton(
                    icon: Icons.check_circle,
                    title: 'Đã giao',
                    action: () {
                      // Navigate to Đã giao page
                    },
                  ),
                  buildOrderButton(
                    icon: Icons.refresh,
                    title: 'Đổi trả',
                    action: () {
                      // Navigate to Đổi trả page
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Sản phẩm bán chạy',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildTrendingProduct(
                    imageUrl: 'https://hanoicomputercdn.com/media/product/69589_laptop_dell_vostro_3520_25.png',
                    title: 'Laptop Dell Vostro 3520',
                    price: '17.599.000',
                    action: () {
                      // Navigate to product page
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        child: Text('Đăng nhập/tạo tài khoản'),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blueAccent,
            child: Icon(
              Icons.person,
              size: 30,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _username,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Người dùng',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear(); // Clear all preferences
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage(title: 'Flutter App')),
                    (route) => false, // Remove all previous routes
              );
            },
          ),
        ],
      ),
    );
  }
}