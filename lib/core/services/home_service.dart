import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/home_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeService {

  static const String url = "http://192.168.0.104:8000/api/home";

  Future<HomeModel?> fetchHomeData() async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");

 // print("TOKEN: $token");

  final response = await http.get(
    Uri.parse(url),
    headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    },
  );

  // print(response.statusCode);
  // print(response.body);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return HomeModel.fromJson(data);
  } else {
    return null;
  }
}
}