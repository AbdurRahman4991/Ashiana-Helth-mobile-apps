// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../models/product_model.dart';
// import '../../config/api_config.dart';
//
// class SearchService {
//
//   static Future<List<Product>> searchProduct(String query) async {
//
//     final response = await http.get(
//         Uri.parse("${ApiConfig.baseUrl}/search?search=$query")
//     );
//
//     if (response.statusCode == 200) {
//
//       final data = json.decode(response.body);
//
//       List list = data['data'];
//
//       return list.map((e) => Product.fromJson(e)).toList();
//
//     } else {
//
//       throw Exception("Failed to load products");
//
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/product_model.dart';
import '../../config/api_config.dart';

class SearchService {
  static Future<Map<String, dynamic>> searchProduct(
      String query, int page) async {

    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/search?search=$query&page=$page"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data['data']; // 👈 pagination object
    } else {
      throw Exception("Failed to load products");
    }
  }
}