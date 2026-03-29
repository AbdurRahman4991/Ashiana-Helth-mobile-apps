import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../../core/services/product_details_service.dart';


class ProductDetailsProvider extends ChangeNotifier {

  final ProductDetailsService _service = ProductDetailsService();

  bool isLoading = false;

  Product? product;
  List<Product> alternativeBrands = [];
  List<Product> recommendedProducts = [];

  Future<void> getProduct(int id) async {

    isLoading = true;
    notifyListeners();

    final data = await _service.fetchProduct(id);

    if (data != null) {
      product = data['product'];
      alternativeBrands = data['alternativeBrands'];
      recommendedProducts = data['recommendedProducts'];
    }

    isLoading = false;
    notifyListeners();
  }
}
// class ProductDetailsProvider extends ChangeNotifier {

//   final ProductDetailsService _service = ProductDetailsService();

//   bool isLoading = false;
//   Product? product;

//   Future<void> getProduct(int id) async {

//     isLoading = true;
//     notifyListeners();

//     product = await _service.fetchProduct(id);

//     isLoading = false;
//     notifyListeners();
//   }
// }