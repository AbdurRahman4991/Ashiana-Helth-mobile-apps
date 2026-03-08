import 'package:flutter/material.dart';
import '../core/services/login_service.dart';
import '../../../core/storage/local_storage.dart';

class LoginProvider extends ChangeNotifier {

  final LoginService _service = LoginService();

  bool isLoading = false;

  Future<bool> login(String phone, String password) async {

    isLoading = true;
    notifyListeners();

    final response = await _service.login(phone, password);

    isLoading = false;
    notifyListeners();

    if (response['status'] == true) {

      String token = response['token'];
      String name = response['user']['name'];
      String contact = response['user']['contact_no'];

      await LocalStorage.saveUser(
        token: token,
        name: name,
        phone: contact,
      );

      return true;
    }

    return false;
  }
}

// class LoginProvider extends ChangeNotifier {
//
//   final LoginService _loginService = LoginService();
//
//   bool isLoading = false;
//
//   Future<bool> login(String phone, String password) async {
//
//     isLoading = true;
//     notifyListeners();
//
//     final response = await _loginService.login(phone, password);
//
//     isLoading = false;
//     notifyListeners();
//
//     if (response['status'] == true) {
//
//       String token = response['token'];
//       String name = response['user']['name'];
//       String phone = response['user']['contact_no'];
//
//       /// SAVE LOCAL STORAGE
//       await LocalStorage.saveUserData(
//         token: token,
//         name: name,
//         phone: phone,
//       );
//
//       return true;
//     }
//
//     return false;
//   }
// }