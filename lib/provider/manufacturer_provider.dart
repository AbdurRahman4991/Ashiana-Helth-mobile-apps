import 'package:flutter/material.dart';
import '../models/Manufacturing.dart';
import '../core/services/manufacturer_service.dart';

class ManufacturingProvider extends ChangeNotifier {
  final ManufacturingService _service = ManufacturingService();

  List<Manufacturing> companies = [];
  bool isLoading = false;

  Future<void> loadCompanies() async {
    isLoading = true;
    notifyListeners();

    companies = await _service.fetchCompanies();

    isLoading = false;
    notifyListeners();
  }
}