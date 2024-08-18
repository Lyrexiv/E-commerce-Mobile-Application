// lib/models/category.dart
class Category {
  final String id;
  final String title;
  final String icon;

  Category({required this.id, required this.title, required this.icon});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['category_id'],
      title: json['name'],
      icon: json['icon'],
    );
  }
}
