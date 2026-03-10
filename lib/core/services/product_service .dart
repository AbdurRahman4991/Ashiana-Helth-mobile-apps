// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../models/product_model.dart'; 
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../config/api_config.dart';


// class ProductService {
//   final String baseUrl = 'http://127.0.0.1:8000/api';
//   final Uri url = Uri.parse("${ApiConfig.baseUrl}/home");

//   // Manufacturer ID অনুযায়ী প্রোডাক্ট fetch
//   Future<List<Product>> getProductsByManufacturer(int manufacturerId) async {
//     final url = '$baseUrl/manufacturers/$manufacturerId';
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body)['data']['data'] as List;
//         return data.map((p) => Product.fromJson(p)).toList();
//       } else {
//         print('Failed to fetch products: ${response.statusCode}');
//         return [];
//       }
//     } catch (e) {
//       print('Error fetching products: $e');
//       return [];
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/api_config.dart';

class ProductService {

  // Manufacturer ID অনুযায়ী প্রোডাক্ট fetch
  Future<List<Product>> getProductsByManufacturer(int manufacturerId) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final Uri url = Uri.parse("${ApiConfig.baseUrl}/manufacturers/$manufacturerId");

    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body)['data']['data'] as List;

      return data.map((p) => Product.fromJson(p)).toList();

    } else {

      print("API Error: ${response.statusCode}");
      return [];

    }
  }
}