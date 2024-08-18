import 'package:flutter/material.dart';
import 'Views/category_page.dart';
import 'Views/notifications_page.dart';
import 'Views/account_page.dart';
import 'Views/HomePage/home_page_content.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // Xử lý sự kiện khi nhấn vào một mục trong thanh điều hướng
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex, // Hiển thị trang dựa trên chỉ mục đã chọn
        children: [
          HomePageContent(), // Nội dung trang chủ
          CategoryPage(),    // Trang danh mục
          NotificationPage(), // Trang thông báo
          AccountPage(),     // Trang tài khoản
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Đặt chỉ mục hiện tại cho thanh điều hướng dưới
        onTap: _onItemTapped, // Xử lý sự kiện khi nhấn vào một mục trong thanh điều hướng
        selectedItemColor: Colors.blue, // Màu sắc cho mục đã chọn
        unselectedItemColor: Colors.grey, // Màu sắc cho các mục chưa được chọn
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Danh mục',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }
}
