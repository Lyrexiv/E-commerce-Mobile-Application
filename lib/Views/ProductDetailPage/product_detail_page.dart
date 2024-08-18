import 'package:flutter/material.dart';
import 'package:ecommerce_mobile_application/models/product_model.dart';
import 'package:ecommerce_mobile_application/option/product_option_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  Future<int?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.favorite_border),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.share),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: FutureBuilder<int?>(
        future: _getUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final int? userId = snapshot.data;

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 300,
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.favorite_border),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text('1/6'),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.star),
                            Icon(Icons.star),
                            Icon(Icons.star),
                            Icon(Icons.star),
                            Icon(Icons.star),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${product.price}₫',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              'Giá sốc',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Mô tả sản phẩm',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.description,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      // Display ProductOptionButtons if user is logged in
                      if (userId != null) ...[
                        ProductOptionButtons(
                          userId: userId,
                          productId: product.id,
                          productName: product.name,
                          price: product.price,
                        ),
                      ] else ...[
                        // Show a message or a button prompting the user to log in to perform certain actions
                        const Text(
                          'Đăng nhập để thêm sản phẩm vào giỏ hàng',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
