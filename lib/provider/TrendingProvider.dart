import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../../core/services/trendingService.dart';

class TrendingProvider extends ChangeNotifier {

  final TrendingService _service = TrendingService();

  List<Product> products = [];

  int currentPage = 1;
  int lastPage = 1;

  bool isLoading = false;
  bool isLoadMore = false;

  /// First Load
  Future<void> fetchTrending() async {
    isLoading = true;
    notifyListeners();

    final res = await _service.fetchTrendingProducts(1);

    if (res != null) {
      products = res['products'];
      currentPage = res['current_page'];
      lastPage = res['last_page'];
    }

    isLoading = false;
    notifyListeners();
  }

  /// Load More
  Future<void> loadMore() async {
    if (currentPage >= lastPage || isLoadMore) return;

    isLoadMore = true;
    notifyListeners();

    final res =
    await _service.fetchTrendingProducts(currentPage + 1);

    if (res != null) {
      products.addAll(res['products']);
      currentPage = res['current_page'];
    }

    isLoadMore = false;
    notifyListeners();
  }
}