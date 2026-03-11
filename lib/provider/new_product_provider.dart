import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../core/services/new_product_service.dart';

class NewProductProvider extends ChangeNotifier {

  final NewProductService _service = NewProductService();

  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchNewProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _service.fetchNewProducts();
    } catch (e) {
      _products = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}