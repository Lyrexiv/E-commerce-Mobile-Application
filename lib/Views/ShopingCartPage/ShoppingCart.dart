import 'package:flutter/material.dart';
import 'package:ecommerce_mobile_application/services/cart_service.dart';
import 'package:ecommerce_mobile_application/models/cart_product_model.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<CartProductModel> cartProducts = [];
  bool isLoading = true;
  String message = '';

  @override
  void initState() {
    super.initState();
    _loadCartProducts();
  }

  void _loadCartProducts() async {
    try {
      final products = await CartAPI().fetchCartProducts();
      setState(() {
        cartProducts = products;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        message = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tính tổng cộng
    double totalAmount = cartProducts.fold(0.0, (sum, product) => sum + product.total);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : cartProducts.isEmpty
          ? Center(child: Text(message))
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cartProducts.map((product) {
              return CartProduct(
                name: product.name,
                quantity: product.quantity,
                price: product.price,
              );
            }).toList(),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng cộng: \$${totalAmount.toStringAsFixed(2)}', // Hiển thị tổng cộng
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Mua Hàng (${cartProducts.length})', // Hiển thị số lượng sản phẩm
                  style: const TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartProduct extends StatelessWidget {
  const CartProduct({
    Key? key,
    required this.name,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  final String name;
  final double price;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(height: 8.0),
                  Text('Giá: \$${price.toStringAsFixed(2)} x $quantity', style: const TextStyle(fontSize: 9)),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.remove),
                ),
                Text('$quantity'),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
