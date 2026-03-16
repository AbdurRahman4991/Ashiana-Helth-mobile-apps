import 'package:flutter/material.dart';
import '../core/services/invoice_service.dart';
import 'dart:typed_data';

class InvoiceProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<Uint8List?> downloadInvoice(int orderId) async {
    try {
      setLoading(true);
      final bytes = await InvoiceService.downloadInvoice(orderId);
      setLoading(false);
      return bytes;
    } catch (e) {
      setLoading(false);
      print("Invoice download error: $e");
      return null;
    }
  }
}