// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../config/api_config.dart';
// import '../../models/manufacturer_model.dart';
//
// class ManufacturerService {
//
//   Future<ManufacturerModel?> fetchProducts(int id) async {
//
//     final Uri url =
//     Uri.parse("${ApiConfig.baseUrl}/manufacturers/$id");
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString("token");
//
//     final response = await http.get(
//       url,
//       headers: {
//         "Accept": "application/json",
//         "Authorization": "Bearer $token",
//       },
//     );
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return ManufacturerModel.fromJson(data);
//     } else {
//       return null;
//     }
//   }
// }