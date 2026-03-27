// import 'package:flutter/material.dart';
// import '../../models/product_model.dart';
// import '../../core/services/new_product_service.dart';

// class NewProductProvider extends ChangeNotifier {

//   final NewProductService _service = NewProductService();

//   List<Product> _products = [];
//   bool _isLoading = false;

//   List<Product> get products => _products;
//   bool get isLoading => _isLoading;

//   Future<void> fetchNewProducts() async {
//     _isLoading = true;
//     notifyListeners();


//     try {
//       _products = await _service.fetchNewProducts();
//     } catch (e) {
//       _products = [];
//     }

//     _isLoading = false;
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../core/services/new_product_service.dart';

class NewProductProvider extends ChangeNotifier {
  final NewProductService _service = NewProductService();

  List<Product> _products = [];
  bool _isLoading = false;
  bool _isLoadMore = false;

  int _currentPage = 1;
  bool _hasMore = true;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  bool get isLoadMore => _isLoadMore;

  /// প্রথম load
  Future<void> fetchNewProducts() async {
    _isLoading = true;
    _currentPage = 1;
    _hasMore = true;
    notifyListeners();

    try {
      final data = await _service.fetchNewProducts(page: _currentPage);
      _products = data;
    } catch (e) {
      _products = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Load more (scroll)
  Future<void> loadMore() async {
    if (_isLoadMore || !_hasMore) return;

    _isLoadMore = true;
    _currentPage++;
    notifyListeners();

    try {
      final data = await _service.fetchNewProducts(page: _currentPage);

      if (data.isEmpty) {
        _hasMore = false;
      } else {
        _products.addAll(data);
      }
    } catch (e) {}

    _isLoadMore = false;
    notifyListeners();
  }
}