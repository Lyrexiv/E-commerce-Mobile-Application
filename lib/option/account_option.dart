import 'package:flutter/material.dart';

Widget buildFeaturedService({
  required IconData icon,
  required Color color,  // Thêm thuộc tính color vào đây
  required String title,
  required VoidCallback action,
}) {
  return GestureDetector(
    onTap: action,
    child: Column(
      children: [
        Icon(
          icon,
          size: 27,
          color: color,  // Sử dụng color cho icon
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ],
    ),
  );
}

Widget buildOrderButton({
  required IconData icon,
  required String title,
  required VoidCallback action,
}) {
  return GestureDetector(
    onTap: action,
    child: Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.blueAccent,
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(fontSize: 10),
        ),
      ],
    ),
  );
}

Widget buildTrendingProduct({
  required String imageUrl,
  required String title,
  required String price,
  required VoidCallback action,
}) {
  return GestureDetector(
    onTap: action,
    child: Column(
      children: [
        Image.network(
          imageUrl,
          height: 100,
          width: 100,
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
        Text(
          price,
          style: TextStyle(
            color: Colors.red,
            fontSize: 10,
          ),
        ),
      ],
    ),
  );
}
