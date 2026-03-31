import 'package:flutter/material.dart';
import '../core/services/change_password_service.dart';

class ChangePasswordProvider extends ChangeNotifier {
  final ChangePasswordService _service = ChangePasswordService();

  bool isLoading = false;
  String message = "";

  /// Reset Password
  Future<bool> resetPassword({
    required String phone,
    required String otp,
    required String password,
    required String confirmPassword,
  }) async {
    isLoading = true;
    notifyListeners();

    final response = await _service.resetPassword(
      phone: phone,
      otp: otp,
      password: password,
      passwordConfirmation: confirmPassword,
    );

    isLoading = false;
    message = response["message"];
    notifyListeners();

    return response["success"];
  }
}