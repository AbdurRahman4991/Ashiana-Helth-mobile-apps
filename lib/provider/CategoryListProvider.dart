import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../core/services/CategoryListService.dart';

class CategoryListProvider extends ChangeNotifier {

  final CategoryListService _service = CategoryListService();

  List<Category> categories = [];
  bool isLoading = false;

  Future<void> loadCategories() async {
    if (categories.isNotEmpty) return; // 🔥 already loaded হলে skip

    isLoading = true;
    notifyListeners();

    try {
      categories = await _service.fetchCategories();
    } catch (e) {
      print(e);
    }

    isLoading = false;
    notifyListeners();
  }
}