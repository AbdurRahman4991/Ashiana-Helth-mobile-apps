import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/product_model.dart';
import '../../config/api_config.dart';

class NewProductService {

  Future<List<Product>> fetchNewProducts({int page = 1}) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/new/products?page=$page"),
      headers: {
        "Accept": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {

      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      final List list = jsonData["data"]["data"];

      // 👇 এখানে print দিন
      print("Product length: ${list.length}");

      return list.map((e) => Product.fromJson(e)).toList();

    } else {
      throw Exception("Failed to load new products");
    }
  }
}