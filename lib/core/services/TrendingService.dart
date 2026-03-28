import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/api_config.dart';
import '../../models/product_model.dart';

class TrendingService {

  Future<Map<String, dynamic>?> fetchTrendingProducts(int page) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final Uri url =
    Uri.parse("${ApiConfig.baseUrl}/products/trending?page=$page");

    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List list = data['data']['data'];

      List<Product> products =
      list.map((e) => Product.fromJson(e)).toList();

      return {
        "products": products,
        "current_page": data['data']['current_page'],
        "last_page": data['data']['last_page'],
      };
    } else {
      return null;
    }
  }
}