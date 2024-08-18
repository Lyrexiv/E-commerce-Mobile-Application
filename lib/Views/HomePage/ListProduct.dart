import 'package:flutter/material.dart';
import '../ShopingCartPage/ShoppingCart.dart'; // Import trang giỏ hàng
import '../../option/homepage_option.dart';
import '../CouponPage/coupon_page.dart';
import 'ListProduct.dart'; // Import ListProduct

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.blueAccent),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: '100% hàng tuyển chọn',
              prefixIcon: const Icon(Icons.search, color: Colors.blueAccent),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.blueAccent),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShoppingCart()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildCategoryItem(
                      icon: Icons.thumb_up_alt,
                      title: 'TOP DEAL',
                      onTap: () {},
                    ),
                    buildCategoryItem(
                      icon: Icons.storefront,
                      title: 'Trading',
                      onTap: () {},
                    ),
                    buildCategoryItem(
                      icon: Icons.percent,
                      title: 'Coupon',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CouponPage()),
                        );
                      },
                    ),
                    buildCategoryItem(
                      icon: Icons.local_offer,
                      title: 'Giảm giá',
                      onTap: () {},
                    ),
                    buildCategoryItem(
                      icon: Icons.airplanemode_active,
                      title: 'Hàng ngoại',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              buildSectionContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildProductItem(
                      image: 'assets/images/img_1.png',
                      title: 'Cùng mẹ chăm bé',
                      onTap: () {},
                    ),
                    buildProductItem(
                      image: 'assets/images/img_2.png',
                      title: 'Sách',
                      onTap: () {},
                    ),
                    buildProductItem(
                      image: 'assets/images/img_3.png',
                      title: 'Công nghệ',
                      onTap: () {},
                    ),
                    buildProductItem(
                      image: 'assets/images/img_4.png',
                      title: 'Yêu bếp',
                      onTap: () {},
                    ),
                    buildProductItem(
                      image: 'assets/images/img_7.png',
                      title: 'Sắc đẹp',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              buildSectionContainer(
                child: const Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.blueAccent),
                    SizedBox(width: 8),
                    Text(
                      'Giao đến: TP. Thủ Đức, P. Hiệp Bình P...',
                      style: TextStyle(color: Colors.black87, fontSize: 9),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              buildSectionContainer(
                child: Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildDealItem(
                        title: 'TOP DEAL • SIÊU RẺ',
                      ),
                      TextButton(
                        onPressed: () {  },
                        child: const Text(
                          'Xem tất cả',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                            fontSize: 10
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              buildSectionContainer(
                child: SizedBox(
                  height: 351, // Điều chỉnh kích thước phù hợp
                  child: ListProduct(), // Hiển thị ListProduct ngay dưới TOP DEAL
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
}


