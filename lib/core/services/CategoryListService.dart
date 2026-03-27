import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/api_config.dart';
import '../../models/category_model.dart';

class CategoryListService {

  final Uri categoryUrl =
      Uri.parse("${ApiConfig.baseUrl}/categories");

  Future<List<Category>> fetchCategories() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final response = await http.get(
      categoryUrl,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List list = data['data'];

      return list.map((e) => Category.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}