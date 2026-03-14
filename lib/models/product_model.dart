// import 'Manufacturing.dart';
// import 'category_model.dart';
//
// class Product {
//   int id;
//   String name;
//   String slug;
//   String image;
//   double sellingPrice;
//   double discountedPrice;
//   double discountPercent;          // ✅ new field
//   Manufacturing manufacturing;
//   Category? category;
//
//   Product({
//     required this.id,
//     required this.name,
//     required this.slug,
//     required this.image,
//     required this.sellingPrice,
//     required this.discountedPrice,
//     required this.discountPercent,   // ✅ new field
//     required this.manufacturing,
//     required this.category,
//   });
//
//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: int.parse(json['id'].toString()),
//       name: json['name'] ?? '',
//       slug: json['slug'] ?? '',
//       image: json['image'] ?? '',
//       sellingPrice: double.parse(json['selling_price'].toString()),
//       discountedPrice: double.parse(json['discounted_price'].toString()),
//       discountPercent: double.parse(json['discount_percent'].toString()), // ✅ parse
//       manufacturing: Manufacturing.fromJson(json['manufacturing']),
//       category: Category.fromJson(json['category']),

//       stock: json['stock'] ?? 0,

//     );
//   }
// }

//
//     );
//   }
// }
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

  Manufacturing? manufacturing;
  Category? category;
  int stock; // make it non-nullable with default 0

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.sellingPrice,
    required this.discountedPrice,
    required this.discountPercent,

    this.manufacturing,
    this.category,
    this.stock = 0, // default 0


  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      image: json['image'] ?? '',
      sellingPrice: double.tryParse(json['selling_price'].toString()) ?? 0,
      discountedPrice: double.tryParse(json['discounted_price'].toString()) ?? 0,

      discountPercent: double.tryParse(json['discount_percent']?.toString() ?? '0') ?? 0,

      discountPercent: double.tryParse(json['discount_percent'].toString()) ?? 0,
      stock: int.tryParse(json['stock'].toString()) ?? 0,

      manufacturing: json['manufacturing'] != null
          ? Manufacturing.fromJson(json['manufacturing'])
          : null,
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,

      stock: json['stock'] != null ? int.tryParse(json['stock'].toString()) ?? 0 : 0,

    );
  }
}