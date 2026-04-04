import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/api_config.dart';

class ForgetService {

  /// Send OTP
  static Future<Map<String, dynamic>> sendOtp(String phone) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/auth/send-otp"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "phone": phone,
        }),
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
}