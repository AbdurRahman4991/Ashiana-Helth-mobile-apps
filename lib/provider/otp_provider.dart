import 'package:flutter/material.dart';
import '../core/services/otp_service.dart';

class OtpProvider extends ChangeNotifier {
  bool isLoading = false;
  String message = "";

  /// Send OTP
  Future<bool> sendOtp(String phone) async {
    isLoading = true;
    notifyListeners();

    final response = await OtpService.sendOtp(phone);

    isLoading = false;
    message = response["message"];
    notifyListeners();

    return response["success"];
  }

  /// Verify OTP
  Future<bool> verifyOtp(String phone, String otp) async {
    isLoading = true;
    notifyListeners();

    final response = await OtpService.verifyOtp(phone, otp);

    isLoading = false;
    message = response["message"];
    notifyListeners();

    return response["success"];
  }
}