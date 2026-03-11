import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../core/services/category_product_service.dart';

class CategoryProductProvider extends ChangeNotifier {

  final CategoryProductService _service = CategoryProductService();

  List<Product> _products = [];

  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts(int categoryId) async {

    _isLoading = true;
    notifyListeners();

    try {

      _products = await _service.getCategoryProducts(categoryId);

    } catch (e) {
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }
}