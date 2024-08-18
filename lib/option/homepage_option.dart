import 'package:flutter/material.dart';

// Build Section Container
Widget buildSectionContainer({required Widget child}) {
  return Container(
    padding: const EdgeInsets.all(7.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey.withOpacity(0.1)),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: child,
  );
}

// Build Category Item
Widget buildCategoryItem({required IconData? icon, required String title, required VoidCallback onTap}) {
  return Expanded(
    child: InkWell(
      onTap: onTap,
      child: Column(
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 26,
              color: Colors.blueAccent,
            ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 9,
            ),
          ),
        ],
      ),
    ),
  );
}

// Build Equal Category Item
Widget buildEqualCategoryItem({required String title, required VoidCallback onTap}) {
  return Flexible(
    child: InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 9,
            ),
          ),
        ],
      ),
    ),
  );
}

// Build Product Item
Widget buildProductItem(
    {required String image, required String title, required VoidCallback onTap}) {
  return Flexible(
    child: InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (image.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                height: 35,
                width: 35,
                fit: BoxFit.cover,
              ),
            ),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 10,
            ),
          ),
        ],
      ),
    ),
  );
}
Widget buildDealItem({required String title}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.blue[100],
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
        fontSize: 10,
      ),
    ),
  );
}

// Widget to display content based on selected category
Widget buildCategoryContent({required String title}) {
  return Center(
    child: Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
  );
}

