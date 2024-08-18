import 'package:flutter/material.dart';
import 'package:ecommerce_mobile_application/services/product_service.dart';
import 'package:ecommerce_mobile_application/models/product_model.dart';

import '../ProductDetailPage/product_detail_page.dart';

class ListProduct extends StatelessWidget {
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    void _navigateToProductDetail(Product product) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(product: product),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Danh sách sản phẩm',
          style: TextStyle(
            fontSize: 14, // Thay đổi kích thước chữ tại đây
          ),
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: _productService.getAllProducts(),
        builder: (context, snapshot) {
          // Xử lý trạng thái đang chờ
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Xử lý lỗi
          if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          }

          // Xử lý khi không có dữ liệu
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Không có sản phẩm nào'));
          }

          // Xử lý khi có dữ liệu
          final products = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.75,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                product: product,
                onTap: () => _navigateToProductDetail(products[index]),
              );
            },
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({Key? key, required this.product, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: product.imageUrl.isNotEmpty
                    ? Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
                    : Placeholder(), // Thay thế bằng Placeholder nếu imageUrl trống
              ),
              SizedBox(height: 8),
              Text(
                product.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text(
                '${product.price.toStringAsFixed(0)} ₫', // Chuyển giá thành chuỗi với định dạng không có số thập phân
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.star, size: 16, color: Colors.yellow),
                  Text(
                    "4.5", // Thay đổi thành đánh giá động nếu có
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Đã bán 219', // Thay đổi thành số lượng bán động nếu có
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                "Giao sáng mai", // Thay đổi thành thông tin giao hàng động nếu có
                style: TextStyle(fontSize: 12, color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


