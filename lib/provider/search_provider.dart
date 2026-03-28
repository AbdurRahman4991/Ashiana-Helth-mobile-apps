// import 'package:flutter/material.dart';
// import '../models/product_model.dart';
// import '../core/services/search_service.dart';
//
// class SearchProvider extends ChangeNotifier {
//   List<Product> products = [];
//   bool isLoading = false;
//
//   Future<void> search(String query) async {
//     if (query.isEmpty) {
//       products = [];
//       notifyListeners();
//       return;
//     }
//
//     isLoading = true;
//     notifyListeners();
//
//     products = await SearchService.searchProduct(query);
//
//     isLoading = false;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../core/services/search_service.dart';

class SearchProvider extends ChangeNotifier {
  List<Product> products = [];

  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMore = true;

  int currentPage = 1;
  String currentQuery = "";

  /// 🔍 First Search
  Future<void> search(String query) async {
    if (query.isEmpty) {
      products = [];
      notifyListeners();
      return;
    }

    currentQuery = query;
    currentPage = 1;
    hasMore = true;

    isLoading = true;
    notifyListeners();

    final res = await SearchService.searchProduct(query, currentPage);

    List list = res['data'];

    products = list.map((e) => Product.fromJson(e)).toList();

    hasMore = res['next_page_url'] != null;

    isLoading = false;
    notifyListeners();
  }

  /// 🔄 Load More
  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore) return;

    isLoadingMore = true;
    notifyListeners();

    currentPage++;

    final res =
    await SearchService.searchProduct(currentQuery, currentPage);

    List list = res['data'];

    products.addAll(list.map((e) => Product.fromJson(e)).toList());

    hasMore = res['next_page_url'] != null;

    isLoadingMore = false;
    notifyListeners();
  }
}