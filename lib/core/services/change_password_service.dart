import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/api_config.dart';

class ChangePasswordService {

  /// Reset Password API call
  Future<Map<String, dynamic>> resetPassword({
    required String phone,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/auth/reset-password"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "phone": phone,
          "otp": otp,
          "password": password,
          "password_confirmation": passwordConfirmation,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          "success": true,
          "message": data["message"] ?? "Password changed successfully"
        };
      } else {
        return {
          "success": false,
          "message": data["message"] ?? "Failed to change password"
        };
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}