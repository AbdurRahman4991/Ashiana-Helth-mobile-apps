import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/cart_model.dart';

class CartService {

  static const String cartKey = "cart";


  static Future<void> addToCart(CartItem item) async {

    final prefs = await SharedPreferences.getInstance();

    List<String> cart = prefs.getStringList(cartKey) ?? [];

    cart.add(jsonEncode(item.toJson()));

    await prefs.setStringList(cartKey, cart);
  }

}