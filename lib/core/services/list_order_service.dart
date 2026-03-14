import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/api_config.dart';
import '../../models/order_model.dart';

class OrderService {
  static Future<List<OrderModel>> fetchOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";

    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/my-orders"),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == true) {
        List ordersJson = data['data'];
        return ordersJson.map((json) => OrderModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception("Failed to fetch orders");
    }
  }
}