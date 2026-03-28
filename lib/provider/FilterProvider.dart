import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../core/services/filter_service.dart';

// class FilterProvider extends ChangeNotifier {
//   final FilterService _service = FilterService();
//
//   List<Product> products = [];
//   bool isLoading = false;
//
//   Future<void> filter({
//     List<int>? categoryIds,
//     List<int>? companyIds,
//     String? search,
//   }) async {
//     isLoading = true;
//     notifyListeners();
//
//     products = await _service.fetchFilteredProducts(
//       categoryIds: categoryIds,
//       companyIds: companyIds,
//       search: search,
//     );
//
//     isLoading = false;
//     notifyListeners();
//   }
// }
class FilterProvider extends ChangeNotifier {
  final FilterService _service = FilterService();

  List<Product> products = [];          // API data
  List<Product> filteredProducts = [];  // Search data

  bool isLoading = false;
  bool isLoadingMore = false;

  int currentPage = 1;
  int lastPage = 1;

  /// 🔹 Initial Load
  Future<void> filter({
    List<int>? categoryIds,
    List<int>? companyIds,
  }) async {
    isLoading = true;
    currentPage = 1;
    products = [];
    filteredProducts = [];

    notifyListeners();

    try {
      final result = await _service.fetchFilteredProducts(
        categoryIds: categoryIds,
        companyIds: companyIds,
        page: currentPage,
      );

      products = result['products'];
      filteredProducts = products; // 🔥 initially same
      currentPage = result['current_page'];
      lastPage = result['last_page'];
    } catch (e) {
      print(e);
    }

    isLoading = false;
    notifyListeners();
  }

  /// 🔍 Local Search
  void searchLocal(String query) {
    if (query.isEmpty) {
      filteredProducts = products;
    } else {
      filteredProducts = products.where((product) {
        return product.name
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }

  /// 🔄 Pagination
  Future<void> loadMore({
    List<int>? categoryIds,
    List<int>? companyIds,
  }) async {
    if (currentPage >= lastPage) return;

    isLoadingMore = true;
    notifyListeners();

    try {
      final result = await _service.fetchFilteredProducts(
        categoryIds: categoryIds,
        companyIds: companyIds,
        page: currentPage + 1,
      );

      products.addAll(result['products']);
      filteredProducts = products; // 🔥 keep sync
      currentPage = result['current_page'];
      lastPage = result['last_page'];
    } catch (e) {
      print(e);
    }

    isLoadingMore = false;
    notifyListeners();
  }
}
// class FilterProvider extends ChangeNotifier {
//   final FilterService _service = FilterService();
//
//   List<Product> products = [];
//   bool isLoading = false;
//   int currentPage = 1;
//   int lastPage = 1;
//   bool isLoadingMore = false;
//
//   Future<void> filter({
//     List<int>? categoryIds,
//     List<int>? companyIds,
//     String? search,
//   }) async {
//     isLoading = true;
//     currentPage = 1;
//     notifyListeners();
//
//     try {
//       final result = await _service.fetchFilteredProducts(
//         categoryIds: categoryIds,
//         companyIds: companyIds,
//         search: search,
//         page: currentPage,
//       );
//
//       products = result['products'];
//       currentPage = result['current_page'];
//       lastPage = result['last_page'];
//     } catch (e) {
//       print(e);
//     }
//
//     isLoading = false;
//     notifyListeners();
//   }
//
//   Future<void> loadMore({
//     List<int>? categoryIds,
//     List<int>? companyIds,
//     String? search,
//   }) async {
//     if (currentPage >= lastPage) return;
//
//     isLoadingMore = true;
//     notifyListeners();
//
//     try {
//       final result = await _service.fetchFilteredProducts(
//         categoryIds: categoryIds,
//         companyIds: companyIds,
//         search: search,
//         page: currentPage + 1,
//       );
//
//       products.addAll(result['products']);
//       currentPage = result['current_page'];
//       lastPage = result['last_page'];
//     } catch (e) {
//       print(e);
//     }
//
//     isLoadingMore = false;
//     notifyListeners();
//   }
//}