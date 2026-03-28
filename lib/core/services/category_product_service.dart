//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../models/product_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../config/api_config.dart';
//
// class CategoryProductService {
//
//   /// 🔹 Get Products
//   Future<List<Product>> getCategoryProducts(int categoryId) async {
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString("token");
//
//     final Uri url = Uri.parse("${ApiConfig.baseUrl}/categories/$categoryId");
//
//     final response = await http.get(
//       url,
//       headers: {
//         "Accept": "application/json",
//         "Authorization": "Bearer $token",
//       },
//     );
//
//     if (response.statusCode == 200) {
//
//       final jsonData = jsonDecode(response.body);
//
//       List productsJson = jsonData['data']['data'];
//
//       return productsJson
//           .map((product) => Product.fromJson(product))
//           .toList();
//
//     } else {
//       throw Exception("Failed to load products");
//     }
//   }
//
//   /// 🔍 Search Products
//   Future<List<Product>> searchCategoryProducts(String keyword, int categoryId) async {
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString("token");
//
//     final Uri url = Uri.parse(
//         "${ApiConfig.baseUrl}/categories/$categoryId?search=$keyword"
//     );
//
//     final response = await http.get(
//       url,
//       headers: {
//         "Accept": "application/json",
//         "Authorization": "Bearer $token",
//       },
//     );
//
//     if (response.statusCode == 200) {
//
//       final jsonData = jsonDecode(response.body);
//
//       List productsJson = jsonData['data']['data'];
//
//       return productsJson
//           .map((product) => Product.fromJson(product))
//           .toList();
//
//     } else {
//       throw Exception("Failed to search products");
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/api_config.dart';

class CategoryProductService {

  /// 🔹 Get Products (with pagination)
  Future<Map<String, dynamic>> getCategoryProducts(int categoryId, {int page = 1, String? search}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    String urlString = "${ApiConfig.baseUrl}/categories/$categoryId?page=$page";
    if (search != null && search.isNotEmpty) {
      urlString += "&search=$search";
    }

    final Uri url = Uri.parse(urlString);

    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'];

      final productsJson = jsonData['data'] as List;

      return {
        'products': productsJson.map((p) => Product.fromJson(p)).toList(),
        'current_page': jsonData['current_page'],
        'last_page': jsonData['last_page'],
      };
    } else {
      throw Exception("Failed to load products");
    }
  }
}