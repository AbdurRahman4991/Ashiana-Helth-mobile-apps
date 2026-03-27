
import 'Manufacturing.dart';
import 'category_model.dart';

class Product {
  int id;
  String name;
  String slug;
  String image;
  double sellingPrice;
  double discountedPrice;
  double discountPercent;
  int stock;

  String manufactureName;   // ✅ NEW
  String genericName;       // ✅ NEW

  Manufacturing? manufacturing;
  Category? category;

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.sellingPrice,
    required this.discountedPrice,
    required this.discountPercent,
    required this.manufactureName,
    required this.genericName,
    this.manufacturing,
    this.category,
    this.stock = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      image: json['image'] ?? '',

      sellingPrice:
      double.tryParse(json['selling_price'].toString()) ?? 0,

      // 🔥 FIX (important)
      discountedPrice:
      double.tryParse(json['discounted_price'].toString()) ?? 0,

      discountPercent:
      double.tryParse(json['discount_percent']?.toString() ?? '0') ?? 0,

      stock: int.tryParse(json['stock']?.toString() ?? '0') ?? 0,

      // ✅ NEW fields
      manufactureName: json['manufacture_name'] ?? '',
      genericName: json['generic_name'] ?? '',

      // optional (if future API send)
      manufacturing: json['manufacturing'] != null
          ? Manufacturing.fromJson(json['manufacturing'])
          : null,

      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
    );
  }
}