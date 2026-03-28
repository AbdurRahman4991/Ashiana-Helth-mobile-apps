//
// import 'package:flutter/material.dart';
// import '../models/product_model.dart';
// import '../core/services/category_product_service.dart';
//
// class CategoryProductProvider extends ChangeNotifier {
//
//   final CategoryProductService _service = CategoryProductService();
//
//   List<Product> _products = [];
//   bool _isLoading = false;
//
//   List<Product> get products => _products;
//   bool get isLoading => _isLoading;
//
//   /// 🔹 Default Load
//   Future<void> fetchProducts(int categoryId) async {
//
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       _products = await _service.getCategoryProducts(categoryId);
//     } catch (e) {
//       print(e);
//     }
//
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   /// 🔍 Search Products (NEW)
//   Future<void> searchProducts(String keyword, int categoryId) async {
//
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       _products = await _service.searchCategoryProducts(keyword, categoryId);
//     } catch (e) {
//       print(e);
//     }
//
//     _isLoading = false;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../core/services/category_product_service.dart';

class CategoryProductProvider extends ChangeNotifier {
  final CategoryProductService _service = CategoryProductService();

  List<Product> _products = [];
  bool _isLoading = false;
  bool _isLoadMore = false;
  int _currentPage = 1;
  int _lastPage = 1;
  String _searchKeyword = '';

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  bool get isLoadMore => _isLoadMore;

  /// 🔹 Load first page
  Future<void> fetchProducts(int categoryId) async {
    _isLoading = true;
    notifyListeners();

    _currentPage = 1;
    _searchKeyword = '';

    try {
      final response = await _service.getCategoryProducts(categoryId, page: _currentPage);
      _products = response['products'];
      _lastPage = response['last_page'];
    } catch (e) {
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }

  /// 🔹 Load more
  Future<void> loadMore(int categoryId) async {
    if (_currentPage >= _lastPage || _isLoadMore) return;

    _isLoadMore = true;
    _currentPage++;
    notifyListeners();

    try {
      final response = await _service.getCategoryProducts(
        categoryId,
        page: _currentPage,
        search: _searchKeyword.isEmpty ? null : _searchKeyword,
      );
      _products.addAll(response['products']);
      _lastPage = response['last_page'];
    } catch (e) {
      print(e);
    }

    _isLoadMore = false;
    notifyListeners();
  }

  /// 🔍 Search
  Future<void> searchProducts(String keyword, int categoryId) async {
    _isLoading = true;
    notifyListeners();

    _currentPage = 1;
    _searchKeyword = keyword;

    try {
      final response = await _service.getCategoryProducts(categoryId, page: _currentPage, search: keyword);
      _products = response['products'];
      _lastPage = response['last_page'];
    } catch (e) {
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }
}