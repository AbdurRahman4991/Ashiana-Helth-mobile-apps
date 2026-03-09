
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/api_config.dart';

class LoginService {

  Future<Map<String, dynamic>> login(
      String phone,
      String password,
      ) async {

    final url = Uri.parse("${ApiConfig.baseUrl}/login");

    final response = await http.post(
      url,
      body: {
        "contact_no": phone,
        "password": password,
      },
    );

    return jsonDecode(response.body);
  }
}