// import 'package:flutter/material.dart';
// import '../core/services/user_service.dart';
// import '../models/user_model.dart';

// class UserProvider extends ChangeNotifier {
//   final UserService _service = UserService();

//   User? _user;
//   bool _isLoading = false;

//   User? get user => _user;
//   bool get isLoading => _isLoading;

//   Future<void> fetchUser() async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       _user = await _service.fetchUser();
//     } catch (e) {
//       print("Error fetching user: $e");
//     }

//     _isLoading = false;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import '../core/services/user_service.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  final UserService _service = UserService();

  User? user;
  bool isLoading = false;
  bool isUpdating = false;
  String message = "";

  Future<void> fetchUser() async {
    isLoading = true;
    notifyListeners();

    try {
      user = await _service.fetchUser();
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  Future<bool> updateProfile({
    required String name,
    required String pharmacyName,
    required String contactNo,
    required String address,
  }) async {
    isUpdating = true;
    notifyListeners();

    try {
      final res = await _service.updateProfile(
        name: name,
        pharmacyName: pharmacyName,
        contactNo: contactNo,
        address: address,
      );

      if (res['success'] == true) {
        user = User.fromJson(res['data']);
        message = res['message'];
        isUpdating = false;
        notifyListeners();
        return true;
      } else {
        message = res['message'] ?? "Failed to update profile";
      }
    } catch (e) {
      message = e.toString();
    }

    isUpdating = false;
    notifyListeners();
    return false;
  }
}