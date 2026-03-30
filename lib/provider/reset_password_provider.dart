import 'package:flutter/material.dart';
import '../core/services/reset_password_service.dart';

class ResetPasswordProvider extends ChangeNotifier {
  final ResetPasswordService _service = ResetPasswordService();

  bool isLoading = false;
  String message = "";

  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _service.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      message = response['message'] ?? "Something went wrong";

      isLoading = false;
      notifyListeners();

      return response['success'] == true;
    } catch (e) {
      isLoading = false;
      message = "Error: $e";
      notifyListeners();
      return false;
    }
  }
}