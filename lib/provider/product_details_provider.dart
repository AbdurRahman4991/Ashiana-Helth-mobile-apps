import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../../core/services/product_details_service.dart';

class ProductDetailsProvider extends ChangeNotifier {

  final ProductDetailsService _service = ProductDetailsService();

  bool isLoading = false;
  Product? product;

  Future<void> getProduct(int id) async {

    isLoading = true;
    notifyListeners();

    product = await _service.fetchProduct(id);

    isLoading = false;
    notifyListeners();
  }
}