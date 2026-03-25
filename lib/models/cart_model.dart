// class CartItem {
//   final int userId;
//   final int productId;
//   final String name;
//   final double price;
//   final String image;
//
//   CartItem({
//     required this.userId,
//     required this.productId,
//     required this.name,
//     required this.price,
//     required this.image,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'user_id': userId,
//       'product_id': productId,
//       'name': name,
//       'price': price,
//       'image': image,
//     };
//   }
// }
class CartItem {
  int userId;
  int productId;
  String name;
  double price;
  String image;
  int qty;

  CartItem({
    required this.userId,
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
    this.qty = 1,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      userId: int.tryParse(json['user_id'].toString()) ?? 0,
      productId: int.tryParse(json['product_id'].toString()) ?? 0,
      name: json['name'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0,
      image: json['image'] ?? '',
      qty: int.tryParse(json['qty'].toString()) ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'product_id': productId,
      'name': name,
      'price': price,
      'image': image,
      'qty': qty,
    };
  }
}