// import 'package:flutter/material.dart';
// import '../models/product_model.dart';
// import '../core/services/product_service .dart';
//
// class ProductProvider with ChangeNotifier {
//   List<Product> products = [];
//   bool loading = false;
//
//   final ProductService service = ProductService(); // service instance
//
//   Future<void> fetchProductsByManufacturer(int manufacturerId) async {
//     loading = true;
//     notifyListeners();
//
//     products = await service.getProductsByManufacturer(manufacturerId);
//
//     loading = false;
//     notifyListeners();
//   }
//
//   // Optional: clear products when switching manufacturer
//   void clearProducts() {
//     products = [];
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../core/services/product_service .dart';

class ProductProvider with ChangeNotifier {
  List<Product> products = [];
  bool loading = false;
  bool isLoadMore = false;
  int currentPage = 1;
  int lastPage = 1;

  final ProductService service = ProductService();

  Future<void> fetchProductsByManufacturer(int manufacturerId) async {
    loading = true;
    notifyListeners();

    currentPage = 1; // reset
    final response = await service.getProductsByManufacturer(manufacturerId, page: currentPage);

    products = response['data'];
    lastPage = response['last_page'] ?? 1;

    loading = false;
    notifyListeners();
  }

  Future<void> loadMore(int manufacturerId) async {
    if (currentPage >= lastPage || isLoadMore) return;

    isLoadMore = true;
    currentPage++;
    notifyListeners();

    final response = await service.getProductsByManufacturer(manufacturerId, page: currentPage);

    products.addAll(response['data']);
    lastPage = response['last_page'] ?? lastPage;

    isLoadMore = false;
    notifyListeners();
  }

  void clearProducts() {
    products = [];
    currentPage = 1;
    lastPage = 1;
    notifyListeners();
  }
}