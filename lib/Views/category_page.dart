import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/category_service.dart';
import 'package:ecommerce_mobile_application/Views/ShopingCartPage/ShoppingCart.dart';
import 'package:ecommerce_mobile_application/Views/ProductPage/ProductPage.dart'; // Thay đổi đường dẫn nếu cần
import 'package:ecommerce_mobile_application/Views/SearchPage/search_page.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Category> categories = [];
  List<Category> filteredCategories = [];
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _searchController.addListener(_filterCategories);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCategories);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    try {
      CategoryService categoryService = CategoryService();
      List<Category> fetchedCategories = await categoryService.fetchCategories();
      setState(() {
        categories = fetchedCategories;
        filteredCategories = fetchedCategories;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error loading categories: $e");
    }
  }

  void _filterCategories() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredCategories = categories.where((category) {
        return category.title.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh Mục'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingCart()),
              );
            },
            icon: Icon(Icons.shopping_cart, color: Colors.blueAccent),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Tìm kiếm sản phẩm ...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onSubmitted: (query) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(query: query),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: filteredCategories.isEmpty
                ? Center(child: Text('Không có danh mục nào'))
                : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                final category = filteredCategories[index];
                return ListTile(
                  leading: Icon(getCategoryIcon(category.icon), size: 30, color: Colors.blueAccent),
                  title: Text(category.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPage(
                          categoryId: int.parse(category.id.toString()), // Đảm bảo categoryId là int
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData getCategoryIcon(String iconName) {
    switch (iconName) {
      case 'Icons.book':
        return Icons.book;
      case 'Icons.toys':
        return Icons.toys;
      case 'Icons.phone_android':
        return Icons.phone_android;
      case 'Icons.home':
        return Icons.home;
      case 'Icons.face':
        return Icons.face;
      case 'Icons.kitchen':
        return Icons.kitchen;
      case 'Icons.woman':
        return Icons.woman;
      case 'Icons.man':
        return Icons.man;
      case 'Icons.shopping_bag':
        return Icons.shopping_bag;
      case 'Icons.luggage':
        return Icons.luggage;
      default:
        return Icons.category;
    }
  }
}
