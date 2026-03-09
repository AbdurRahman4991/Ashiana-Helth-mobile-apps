import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/home_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/api_config.dart';

class HomeService {

  final Uri url = Uri.parse("${ApiConfig.baseUrl}/home");

  Future<HomeModel?> fetchHomeData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return HomeModel.fromJson(data);
    } else {
      return null;
    }
  }
}