import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailService {
  final Uri urlBase = Uri.parse("${ApiConfig.baseUrl}/orders");

  /// Fetch order details by orderId
  Future<Map<String, dynamic>> getOrderById(int orderId) async {
    // Get token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final Uri url = Uri.parse("${urlBase.toString()}/$orderId");

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    // Check response status
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['data']; // Return the 'data' object from API
    } else {
      throw Exception("Failed to load order details");
    }
  }
}