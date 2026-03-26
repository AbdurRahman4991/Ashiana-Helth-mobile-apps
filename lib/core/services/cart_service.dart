
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/cart_model.dart';

class CartService {
  static const String cartKey = "cart";

  /// Real-time cart count for badge
  static ValueNotifier<int> cartCount = ValueNotifier<int>(0);

  /// Load cart count on app start / login
  static Future<void> loadCartCount() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getStringList(cartKey) ?? [];
    final cartItems =
        cartData.map((e) => CartItem.fromJson(jsonDecode(e))).toList();

    cartCount.value = cartItems.fold(0, (sum, item) => sum + item.qty);
  }

  /// Add new item or increase qty if already in cart
  static Future<void> addToCart(CartItem item) async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getStringList(cartKey) ?? [];
    final cartItems =
        cartData.map((e) => CartItem.fromJson(jsonDecode(e))).toList();

    final index =
        cartItems.indexWhere((element) => element.productId == item.productId);

    if (index != -1) {
      cartItems[index].qty += item.qty;
    } else {
      cartItems.add(item);
    }

    await prefs.setStringList(
        cartKey, cartItems.map((e) => jsonEncode(e.toJson())).toList());

    cartCount.value = cartItems.fold(0, (sum, item) => sum + item.qty);
  }

  /// Update cart item qty
  static Future<void> updateCartItem(CartItem item) async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getStringList(cartKey) ?? [];
    final cartItems =
        cartData.map((e) => CartItem.fromJson(jsonDecode(e))).toList();

    final index =
        cartItems.indexWhere((element) => element.productId == item.productId);

    if (index != -1) {
      cartItems[index] = item;
    }

    await prefs.setStringList(
        cartKey, cartItems.map((e) => jsonEncode(e.toJson())).toList());

    cartCount.value = cartItems.fold(0, (sum, item) => sum + item.qty);
  }

  /// Remove a single cart item
  static Future<void> removeCartItem(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getStringList(cartKey) ?? [];
    final cartItems =
        cartData.map((e) => CartItem.fromJson(jsonDecode(e))).toList();

    cartItems.removeWhere((item) => item.productId == productId);

    await prefs.setStringList(
        cartKey, cartItems.map((e) => jsonEncode(e.toJson())).toList());

    cartCount.value = cartItems.fold(0, (sum, item) => sum + item.qty);
  }

  /// Clear all cart
  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cartKey);
    cartCount.value = 0;
  }

  /// Get all cart items
  static Future<List<CartItem>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getStringList(cartKey) ?? [];
    return cartData.map((e) => CartItem.fromJson(jsonDecode(e))).toList();
  }

  /// Check if a product is already in cart
  static Future<CartItem?> getCartItemByProductId(int productId) async {
    final items = await getCartItems();
    try {
      return items.firstWhere((item) => item.productId == productId);
    } catch (e) {
      return null;
    }
  }
}