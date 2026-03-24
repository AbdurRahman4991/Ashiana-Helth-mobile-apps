// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../models/product_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../config/api_config.dart';

// class CategoryProductService {

//   Future<List<Product>> getCategoryProducts(int categoryId) async {

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString("token");

//     final Uri url = Uri.parse("${ApiConfig.baseUrl}/categories/$categoryId");

//     final response = await http.get(
//       url,
//       headers: {
//         "Accept": "application/json",
//         "Authorization": "Bearer $token",
//       },
//     );

//     if (response.statusCode == 200) {

//       final jsonData = jsonDecode(response.body);

//       List productsJson = jsonData['data']['data'];

//       return productsJson
//           .map((product) => Product.fromJson(product))
//           .toList();

//     } else {
//       throw Exception("Failed to load products");
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/api_config.dart';

class CategoryProductService {

  /// 🔹 Get Products
  Future<List<Product>> getCategoryProducts(int categoryId) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final Uri url = Uri.parse("${ApiConfig.baseUrl}/categories/$categoryId");

    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {

      final jsonData = jsonDecode(response.body);

      List productsJson = jsonData['data']['data'];

      return productsJson
          .map((product) => Product.fromJson(product))
          .toList();

    } else {
      throw Exception("Failed to load products");
    }
  }

  /// 🔍 Search Products
  Future<List<Product>> searchCategoryProducts(String keyword, int categoryId) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final Uri url = Uri.parse(
        "${ApiConfig.baseUrl}/categories/$categoryId?search=$keyword"
    );

    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {

      final jsonData = jsonDecode(response.body);

      List productsJson = jsonData['data']['data'];

      return productsJson
          .map((product) => Product.fromJson(product))
          .toList();

    } else {
      throw Exception("Failed to search products");
    }
  }
}