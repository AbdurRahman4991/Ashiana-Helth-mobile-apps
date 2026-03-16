import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/product_model.dart';
import '../../config/api_config.dart';

class SearchService {

  static Future<List<Product>> searchProduct(String query) async {

    final response = await http.get(
        Uri.parse("${ApiConfig.baseUrl}/search?search=$query")
    );

    if (response.statusCode == 200) {

      final data = json.decode(response.body);

      List list = data['data'];

      return list.map((e) => Product.fromJson(e)).toList();

    } else {

      throw Exception("Failed to load products");

    }
  }
}