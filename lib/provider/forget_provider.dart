import 'package:flutter/material.dart';
import '../core/services/forget_service.dart';

class ForgetProvider extends ChangeNotifier {
  bool isLoading = false;
  String message = "";

  Future<bool> sendOtp(String phone) async {
    isLoading = true;
    notifyListeners();

    final response = await ForgetService.sendOtp(phone);

    isLoading = false;
    message = response["message"];
    notifyListeners();

    return response["success"];
  }
}