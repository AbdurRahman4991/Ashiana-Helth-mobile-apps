// Future<CartItem?> getCartItem(String productId) async {
//   final prefs = await SharedPreferences.getInstance();
//   final cartData = prefs.getStringList(CartService.cartKey) ?? [];
//   List<CartItem> cartItems =
//       cartData.map((e) => CartItem.fromJson(jsonDecode(e))).toList();

//   try {
//     return cartItems.firstWhere((item) => item.productId == productId);
//   } catch (e) {
//     return null;
//   }
// }