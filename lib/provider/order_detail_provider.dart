import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../core/services/order_detail_service.dart';

class OrderDetailProvider extends ChangeNotifier {
  OrderModel? _order;
  bool _loading = false;

  OrderModel? get order => _order;
  bool get loading => _loading;

  /// Fetch order details by orderId
  Future<void> fetchOrder(int orderId) async {
    _loading = true;
    notifyListeners();

    try {
      final data = await OrderDetailService().getOrderById(orderId);
      _order = OrderModel.fromJson(data);
    } catch (e) {
      print("Error fetching order details: $e");
      _order = null;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}