// import 'package:flutter/material.dart';
// import '../models/manufacturer_model.dart';
// import '../core/services/manufacturer_service.dart';
//
// class ManufacturerProvider extends ChangeNotifier {
//
//   ManufacturerModel? manufacturerModel;
//   bool isLoading = false;
//
//   final ManufacturerService _service = ManufacturerService();
//
//   Future<void> getProducts(int id) async {
//     isLoading = true;
//     notifyListeners();
//
//     manufacturerModel = await _service.fetchProducts(id);
//
//     isLoading = false;
//     notifyListeners();
//   }
// }