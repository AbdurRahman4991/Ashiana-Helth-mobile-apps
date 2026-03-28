import 'package:flutter/material.dart';
import '../models/Manufacturing.dart';
import '../core/services/manufacturer_service.dart';

class ManufacturingProvider extends ChangeNotifier {
  final ManufacturingService _service = ManufacturingService();

  List<Manufacturing> companies = [];
  bool isLoading = false;

  Future<void> loadCompanies() async {
    if (companies.isNotEmpty) return; // 🔥 already loaded হলে skip

    isLoading = true;
    notifyListeners();

    try {
      companies = await _service.fetchCompanies();
    } catch (e) {
      print(e);
    }

    isLoading = false;
    notifyListeners();
  }
}