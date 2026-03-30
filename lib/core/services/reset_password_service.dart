import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/api_config.dart';

class ResetPasswordService {
  final Uri url = Uri.parse("${ApiConfig.baseUrl}/user/reset-password");

  Future<Map<String, dynamic>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
      body: {
        "old_password": oldPassword,
        "new_password": newPassword,
        "new_password_confirmation": confirmPassword,
      },
    );

    return jsonDecode(response.body);
  }
}