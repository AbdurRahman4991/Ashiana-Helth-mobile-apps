// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class ProductDetailsService {
//   final String baseUrl = "http://127.0.0.1:8000/api"; // 🔥 localhost use করো না
//
//   Future<Map<String, dynamic>?> fetchProduct(int id) async {
//     try {
//       final response = await http.get(
//         Uri.parse("$baseUrl/products/$id"),
//       );
//
//       if (response.statusCode == 200) {
//         return json.decode(response.body);
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print("API Error: $e");
//       return null;
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/api_config.dart';
import '../../models/product_model.dart';

class ProductDetailsService {

  Future<Product?> fetchProduct(int id) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final Uri url = Uri.parse("${ApiConfig.baseUrl}/products/$id");

    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Product.fromJson(data);
    } else {
      return null;
    }
  }
}