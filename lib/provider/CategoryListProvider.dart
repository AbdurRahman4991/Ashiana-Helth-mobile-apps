import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../core/services/CategoryListService.dart';

class CategoryListProvider extends ChangeNotifier {

  final CategoryListService _service = CategoryListService();

  List<Category> categories = [];
  bool isLoading = false;

  Future<void> loadCategories() async {
    isLoading = true;
    notifyListeners();

    categories = await _service.fetchCategories();

    isLoading = false;
    notifyListeners();
  }
}