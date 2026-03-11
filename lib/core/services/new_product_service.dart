import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/product_model.dart';
import '../../config/api_config.dart';

class NewProductService {

  Future<List<Product>> fetchNewProducts({int page = 1}) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token"); // token নিলাম

    print("User Token: $token"); // token console এ দেখাবে

    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/new/products?page=$page"),
      headers: {
        "Accept": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List productsJson = data['data']['data'] ?? [];

      return productsJson.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load new products");
    }
  }
}