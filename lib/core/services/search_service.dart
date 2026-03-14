import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/product_model.dart';

class SearchService {
  static const String baseUrl = "http://127.0.0.1:8000/api";

  static Future<List<Product>> searchProduct(String query) async {
    final response =
        await http.get(Uri.parse("$baseUrl/search?search=$query"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List list = data['data'];

      return list.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }
}