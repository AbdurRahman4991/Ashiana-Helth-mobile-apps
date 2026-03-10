import 'Manufacturing.dart';

class Product {
  int id;
  String name;
  String slug;
  String image;
  double sellingPrice;
  double discountedPrice;
  double discountPercent;          // ✅ new field
  Manufacturing manufacturing;

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.sellingPrice,
    required this.discountedPrice,
    required this.discountPercent,   // ✅ new field
    required this.manufacturing,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.parse(json['id'].toString()),
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      image: json['image'] ?? '',
      sellingPrice: double.parse(json['selling_price'].toString()),
      discountedPrice: double.parse(json['discounted_price'].toString()),
      discountPercent: double.parse(json['discount_percent'].toString()), // ✅ parse
      manufacturing: Manufacturing.fromJson(json['manufacturing']),
    );
  }
}