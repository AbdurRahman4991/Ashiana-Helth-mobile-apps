// import 'package:flutter/material.dart';
// import '../core/services/login_service.dart';
// import '../../../core/storage/local_storage.dart';

// class LoginProvider extends ChangeNotifier {

//   final LoginService _service = LoginService();

//   bool isLoading = false;

//   Future<bool> login(String phone, String password) async {

//     isLoading = true;
//     notifyListeners();

//     final response = await _service.login(phone, password);

//     isLoading = false;
//     notifyListeners();

//     if (response['status'] == true) {

//       String token = response['token'];
//       String id = response['user']['id'];
//       String name = response['user']['name'];
//       String contact = response['user']['contact_no'];

//       await LocalStorage.saveUser(
//         token: token,
//         id:id,
//         name: name,
//         phone: contact,
//       );

//       return true;
//     }

//     return false;
//   }
// }
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
      // ID-কে সবসময় String এ convert করা
      String token = response['token'];
      String id = response['user']['id'].toString(); 
      String name = response['user']['name'];
      String contact = response['user']['contact_no'];

      await LocalStorage.saveUser(
        token: token,
        id: id,
        name: name,
        phone: contact,
      );

      print("Login successful, userId saved: $id");

      return true;
    }

    print("Login failed");
    return false;
  }
}