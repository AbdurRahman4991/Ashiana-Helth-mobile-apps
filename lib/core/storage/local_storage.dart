
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/cart_model.dart';
import 'dart:convert';

class LocalStorage {

  static Future<void> saveUser({
    required String token,
    required String id,
    required String name,
    required String phone,
  }) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("token", token);
    await prefs.setString("id", id);
    await prefs.setString("name", name);
    await prefs.setString("contact_no", phone);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  static Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("name");
  }

  static Future<String?> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id");
  }

  static Future<String?> getPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("contact_no");
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Add to card


}