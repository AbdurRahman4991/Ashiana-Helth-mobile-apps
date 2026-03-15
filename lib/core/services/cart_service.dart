// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../models/cart_model.dart';
//
// class CartService {
//
//   static const String cartKey = "cart";
//
//
//   static Future<void> addToCart(CartItem item) async {
//
//     final prefs = await SharedPreferences.getInstance();
//
//     List<String> cart = prefs.getStringList(cartKey) ?? [];
//
//     cart.add(jsonEncode(item.toJson()));
//
//     await prefs.setStringList(cartKey, cart);
//   }
//
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/cart_model.dart';

class CartService {

  static const String cartKey = "cart";

  // 🔴 Real time cart count
  static ValueNotifier<int> cartCount = ValueNotifier<int>(0);

  static Future<void> loadCartCount() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(cartKey) ?? [];
    cartCount.value = cart.length;
  }

  static Future<void> addToCart(CartItem item) async {

    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(cartKey) ?? [];

    cart.add(jsonEncode(item.toJson()));

    await prefs.setStringList(cartKey, cart);

    // 🔴 update count
    cartCount.value = cart.length;
  }

  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cartKey);

    cartCount.value = 0;
  }
}