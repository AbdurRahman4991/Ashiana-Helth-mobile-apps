// import 'package:flutter/material.dart';
// import '../core/services/auth_service.dart';
//
//
// class AuthProvider extends ChangeNotifier {
//
//   final AuthService _authService = AuthService();
//
//   bool loading = false;
//   String message = "";
//
//   Future<bool> register({
//     required String pharmacyName,
//     required String contactNo,
//     required String name,
//     required String address,
//     required String password,
//     required String roleId,
//     required String roleName,
//
//   }) async {
//
//     loading = true;
//     notifyListeners();
//
//     final response = await _authService.registerUser(
//       pharmacyName: pharmacyName,
//       contactNo: contactNo,
//       name: name,
//       address: address,
//       password: password,
//       roleId: roleId,
//       roleName: roleName
//
//     );
//
//     loading = false;
//
//     if (response["status"] == true) {
//       message = response["message"];
//       notifyListeners();
//       return true;
//     } else {
//       message = "Registration Failed";
//       notifyListeners();
//       return false;
//     }
//   }
// }

import 'package:flutter/material.dart';
import '../core/services/auth_service.dart';
class AuthProvider extends ChangeNotifier {

  final AuthService _authService = AuthService();

  bool loading = false;
  String message = ""; // ✅ server message রাখার জন্য

  Future<bool> register({
    required String pharmacyName,
    required String contactNo,
    required String name,
    required String address,
    required String password,
    required String roleId,
    required String roleName,
  }) async {

    loading = true;
    message = "";
    notifyListeners();

    try {
      final response = await _authService.registerUser(
          pharmacyName: pharmacyName,
          contactNo: contactNo,
          name: name,
          address: address,
          password: password,
          roleId: roleId,
          roleName: roleName
      );

      loading = false;

      if (response["status"] == true) {
        message = response["message"] ?? "Registration Successful";
        notifyListeners();
        return true;
      } else {
        message = response["message"] ?? "Registration Failed";
        notifyListeners();
        return false;
      }
    } catch (e) {
      loading = false;
      message = "Something went wrong. Please try again.";
      notifyListeners();
      return false;
    }
  }
}