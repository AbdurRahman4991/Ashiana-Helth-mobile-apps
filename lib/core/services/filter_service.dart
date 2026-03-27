import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/api_config.dart';
import '../../models/product_model.dart';

class FilterService {
  Future<List<Product>> fetchFilteredProducts({
    List<int>? categoryIds,
    List<int>? companyIds,
    String? search,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    // 🔥 Query build
    Map<String, String> queryParams = {};

    if (categoryIds != null) {
      for (int i = 0; i < categoryIds.length; i++) {
        queryParams['category_ids[$i]'] = categoryIds[i].toString();
      }
    }

    if (companyIds != null) {
      for (int i = 0; i < companyIds.length; i++) {
        queryParams['company_ids[$i]'] = companyIds[i].toString();
      }
    }

    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }

    final uri = Uri.parse("${ApiConfig.baseUrl}/products/filter")
        .replace(queryParameters: queryParams);

    final response = await http.post(uri, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List list = data['data'];
      return list.map((e) => Product.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}