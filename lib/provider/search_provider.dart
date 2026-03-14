import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../core/services/search_service.dart';

class SearchProvider extends ChangeNotifier {
  List<Product> products = [];
  bool isLoading = false;

  Future<void> search(String query) async {
    if (query.isEmpty) {
      products = [];
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    products = await SearchService.searchProduct(query);

    isLoading = false;
    notifyListeners();
  }
}