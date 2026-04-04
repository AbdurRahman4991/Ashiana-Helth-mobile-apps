import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/api_config.dart';

class OtpService {

  /// Send OTP
  static Future<Map<String, dynamic>> sendOtp(String phone) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/auth/send-otp"),

        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"phone": phone}),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {"success": true, "message": data["message"]};
      } else {
        return {"success": false, "message": data["message"] ?? "Failed"};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  /// Verify OTP
  static Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/auth/verify-otp"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"phone": phone, "otp": otp}),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {"success": true, "message": data["message"]};
      } else {
        return {"success": false, "message": data["message"] ?? "Invalid OTP"};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}