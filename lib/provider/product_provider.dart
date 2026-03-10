import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../core/services/product_service .dart';

class ProductProvider with ChangeNotifier {
  List<Product> products = [];
  bool loading = false;

  final ProductService service = ProductService(); // service instance

  Future<void> fetchProductsByManufacturer(int manufacturerId) async {
    loading = true;
    notifyListeners();

    products = await service.getProductsByManufacturer(manufacturerId);

    loading = false;
    notifyListeners();
  }

  // Optional: clear products when switching manufacturer
  void clearProducts() {
    products = [];
    notifyListeners();
  }
}