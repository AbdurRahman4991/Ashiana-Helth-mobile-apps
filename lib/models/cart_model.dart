class CartItem {
  final int userId;
  final int productId;
  final String name;
  final double price;
  final String image;

  CartItem({
    required this.userId,
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'product_id': productId,
      'name': name,
      'price': price,
      'image': image,
    };
  }
}