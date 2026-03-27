import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../core/services/filter_service.dart';

class FilterProvider extends ChangeNotifier {
  final FilterService _service = FilterService();

  List<Product> products = [];
  bool isLoading = false;

  Future<void> filter({
    List<int>? categoryIds,
    List<int>? companyIds,
    String? search,
  }) async {
    isLoading = true;
    notifyListeners();

    products = await _service.fetchFilteredProducts(
      categoryIds: categoryIds,
      companyIds: companyIds,
      search: search,
    );

    isLoading = false;
    notifyListeners();
  }
}