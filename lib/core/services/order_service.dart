import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderService {

  final Uri url = Uri.parse("${ApiConfig.baseUrl}/orders");

  Future<bool> placeOrder(List items) async {
    // get token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    // print("TOKEN: $token");
    // print("ITEMS: $items");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
      body: jsonEncode({
        "items": items
      }),
    );

    // print("STATUS: ${response.statusCode}");
    // print("BODY: ${response.body}");

    return response.statusCode == 201;
  }
}