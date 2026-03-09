// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class LoginService {
//
//   Future<Map<String, dynamic>> login(String phone, String password) async {
//
//     final url = Uri.parse("http://127.0.0.1:8000/api/login");
//
//     final response = await http.post(
//       url,
//       body: {
//         "contact_no": phone,
//         "password": password,
//       },
//     );
//
//     final data = jsonDecode(response.body);
//
//     return data;
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {

  Future<Map<String, dynamic>> login(
      String phone,
      String password,
      ) async {

    final url = Uri.parse("http://192.168.0.104:8000/api/login");

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