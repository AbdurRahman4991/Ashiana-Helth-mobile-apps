
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/api_config.dart';

class OrderService {

  static Future<bool> placeOrder(
      int userId, List items, String token) async {

    final response = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/orders"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode({
        "user_id": userId,
        "items": items
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      print(response.body);
      return false;
    }
  }
}