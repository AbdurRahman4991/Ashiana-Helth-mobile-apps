import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/api_config.dart';
import '../../models/order_model.dart';

class MyOrderService {

  static Future<List<OrderModel>> fetchOrders() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/my-orders"),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      List orders = data['data'];

      return orders.map((e) => OrderModel.fromJson(e)).toList();

    } else {

      throw Exception("Failed to load orders");

    }
  }
}