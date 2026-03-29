
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/api_config.dart';
import '../../models/product_model.dart';

class ProductDetailsService {

  Future<Map<String, dynamic>?> fetchProduct(int id) async {

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

      return {
        "product": Product.fromJson(data['data']['product']),
        "alternativeBrands": (data['data']['alternativeBrands'] as List)
            .map((e) => Product.fromJson(e))
            .toList(),
        "recommendedProducts": (data['data']['recommendedProducts'] as List)
            .map((e) => Product.fromJson(e))
            .toList(),
      };
    } else {
      return null;
    }
  }
}

// class ProductDetailsService {

//   Future<Product?> fetchProduct(int id) async {

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString("token");

//     final Uri url = Uri.parse("${ApiConfig.baseUrl}/products/$id");

//     final response = await http.get(
//       url,
//       headers: {
//         "Accept": "application/json",
//         "Authorization": "Bearer $token",
//       },
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return Product.fromJson(data['data']);
//     } else {
//       return null;
//     }
//   }
// }