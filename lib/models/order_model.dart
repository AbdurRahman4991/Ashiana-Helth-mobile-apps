import 'product_model.dart';
class OrderItem {

  final int id;
  final int productId;
  final double sellingPrice;
  final double discountPercent;
  final double discountedPrice;
  final int qty;
  final Product? product;

  OrderItem({
    required this.id,
    required this.productId,
    required this.sellingPrice,
    required this.discountPercent,
    required this.discountedPrice,
    required this.qty,
    this.product,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      productId: json['product_id'],
      sellingPrice: double.parse(json['selling_price'].toString()),
      discountPercent: double.parse(json['discount_percent'].toString()),
      discountedPrice: double.parse(json['discounted_price'].toString()),
      qty: json['qty'],
      product: json['product'] != null
          ? Product.fromJson(json['product'])
          : null,
    );
  }
}

class OrderModel {
  final int id;
  final int userId;
  final double total;
  final String status;
  final String createdAt;
  final List<OrderItem> orderItems;

  OrderModel({
    required this.id,
    required this.userId,
    required this.total,
    required this.status,
    required this.createdAt,
    required this.orderItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    var items = (json['order_items'] as List)
        .map((i) => OrderItem.fromJson(i))
        .toList();

    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      total: double.parse(json['total'].toString()),
      status: json['status'],
      createdAt: json['created_at'],
      orderItems: items,
    );
  }
}