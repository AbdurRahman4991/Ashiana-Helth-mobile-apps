import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/api_config.dart';


class AuthService {

  Future<Map<String, dynamic>> registerUser({
    required String pharmacyName,
    required String contactNo,
    required String name,
    required String address,
    required String password,
    required String roleId,
    required String roleName,
  }) async {

    final url = Uri.parse("${ApiConfig.baseUrl}/register");

    final response = await http.post(
      url,
      body: {
        "pharmacy_name": pharmacyName,
        "contact_no": contactNo,
        "name": name,
        "address": address,
        "password": password,
        "roleid": roleId,
        "role_name": roleName,
      },
    );

    return jsonDecode(response.body);
  }
}