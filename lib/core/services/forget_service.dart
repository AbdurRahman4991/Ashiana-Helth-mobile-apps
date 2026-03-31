import 'dart:convert';
import 'package:http/http.dart' as http;

class ForgetService {
  static const String baseUrl = "http://192.168.20.203:8000/api";

  /// Send OTP
  static Future<Map<String, dynamic>> sendOtp(String phone) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/send-otp"),
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