// import 'dart:typed_data';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../config/api_config.dart';

// class InvoiceService {
//   /// Download invoice by orderId
//   static Future<Uint8List?> downloadInvoice(int orderId) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString("token");

//     if (token == null) {
//       print("No token found!");
//       return null;
//     }

//     final Uri url = Uri.parse("${ApiConfig.baseUrl}/orders/$orderId/invoice");

//     final response = await http.get(
//       url,
//       headers: {
//         "Accept": "application/json",
//         "Authorization": "Bearer $token",
//       },
//     );

//     if (response.statusCode == 200) {
//       return response.bodyBytes;
//     } else {
//       print("Invoice download failed: ${response.statusCode}");
//       return null;
//     }
//   }
// }

import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/api_config.dart';

class InvoiceService {
  static Future<Uint8List?> downloadInvoice(int orderId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    if (token == null) {
      print("No token found!");
      return null;
    }

    final Uri url =
        Uri.parse("${ApiConfig.baseUrl}/orders/$orderId/invoice");

    final response = await http.get(
      url,
      headers: {
        "Accept": "application/pdf", // ✅ FIXED
        "Authorization": "Bearer $token",
      },
    );

    print("Status Code: ${response.statusCode}");

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      print("Error Body: ${response.body}");
      return null;
    }
  }
}