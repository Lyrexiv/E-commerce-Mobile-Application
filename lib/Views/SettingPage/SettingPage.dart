import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_mobile_application/Views/ProfilePage/UserProfile.dart';

import '../../main.dart';
class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          // Account Information
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Thông tin tài khoản'),
            subtitle: const Text('58'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountInfoPage()),
              );
            },
          ),
          // Social Media Connections
          ListTile(
            leading: const Icon(Icons.link),
            title: const Text('Kết nối mạng xã hội'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to social media connections page
            },
          ),
          // Address Book
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Sổ địa chỉ'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to address book page
            },
          ),
          // Payment Information
          ListTile(
            leading: const Icon(Icons.credit_card),
            title: const Text('Thông tin thanh toán'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to payment information page
            },
          ),
          // Security Settings
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Thiết lập bảo mật'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to security settings page
            },
          ),
          // Delete Account
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Yêu cầu xóa tài khoản'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Show delete account confirmation dialog
            },
          ),
          // Notification Settings
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Thiết lập thông báo'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to notification settings page
            },
          ),
          // Version
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Phiên bản'),
            subtitle: const Text('4.149.0.1700646'),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.red, width: 2)),
          color: Colors.red,
        ),
        child: Center(
          child: TextButton(
            child: Text(
              'Đăng Xuất',
              style: TextStyle(color: Colors.white),
            ),
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
        ),
      ),
    );
  }
}