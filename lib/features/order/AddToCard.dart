
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/TopNavigationBar.dart';
import '../../../widget/common/drowerRight.dart';
import '../../core/services/order_service.dart';

// class CartItem {
//   String name;
//   double price;
//   int qty;
//   String image;
//   String userId;

//   CartItem({
//     required this.name,
//     required this.price,
//     required this.qty,
//     required this.image,
//     required this.userId,
//   });

//   factory CartItem.fromJson(Map<String, dynamic> json) {
//     return CartItem(
//       name: json['name'],
//       price: json['price'].toDouble(),
//       qty: 1, // প্রথমে quantity 1 ধরে নেব
//       image: json['image'],
//       userId: json['id'].toString(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'price': price,
//       'qty': qty,
//       'image': image,
//       'id': userId
//     };
//   }
// }
class CartItem {
  String name;
  double price;
  int qty;
  String image;
  String userId;       // keep String
  String productId;    // keep String
  double discountPercent;  // numeric

  CartItem({
    required this.name,
    required this.price,
    required this.qty,
    required this.image,
    required this.userId,
    required this.productId,
    required this.discountPercent,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      name: json['name'].toString(),
      price: (json['price'] ?? 0).toDouble(),
      qty: (json['qty'] ?? 1),
      image: json['image'].toString(),
      userId: json['user_id'].toString(),
      productId: json['product_id'].toString(),
      discountPercent: (json['discount_percent'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "product_id": productId,
      "name": name,
      "price": price,
      "qty": qty,
      "image": image,
      'discount_percent': discountPercent,
    };
  }
}

// class CartItem {
//   String name;
//   double price;
//   int qty;
//   String image;
//   String userId;
//   String productId;
//   String discountPercent;

//   CartItem({
//     required this.name,
//     required this.price,
//     required this.qty,
//     required this.image,
//     required this.userId,
//     required this.productId,
//     required this.discountPercent,
//   });

//   factory CartItem.fromJson(Map<String, dynamic> json) {
//     return CartItem(
//       name: json['name'],
//       price: (json['price']).toDouble(),
//       qty: json['qty'] ?? 1,
//       image: json['image'],
//       userId: json['user_id'].toString(),
//       productId: json['product_id'].toString(),
//       discountPercent: (json['discountPercent'] ?? 0).toDouble(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "user_id": userId,
//       "product_id": productId,
//       "name": name,
//       "price": price,
//       "qty": qty,
//       "image": image,
//       'discount_percent': discountPercent
//     };
//   }
// }

class BagPage extends StatefulWidget {
  const BagPage({super.key});

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  List<CartItem> items = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> cartData = prefs.getStringList('cart') ?? [];

    List<CartItem> loadedItems = cartData.map((item) {
      final Map<String, dynamic> jsonItem = jsonDecode(item);
      return CartItem.fromJson(jsonItem);
    }).toList();

    setState(() {
      items = loadedItems;
    });
  }

  double getTotal() {
    double total = 0;
    for (var item in items) {
      total += item.price * item.qty;
    }
    return total;
  }

  Future<void> _saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartData = items.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList('cart', cartData);
  }

  // List getOrderItems() {
  //   return items.map((item) {
  //     return {

  //       "selling_price": item.price,

  //       "qty": item.qty
  //     };
  //   }).toList();
  // }

  List getOrderItems() {
  return items.map((item) {
    return {
      "product_id": item.productId,
      "selling_price": item.price,
      "qty": item.qty,
      "discount_percent": item.discountPercent ?? 0,
    };
  }).toList();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      endDrawer: const DrowerRight(),
      bottomNavigationBar: const CustomBottomNav(),
      body: Column(
        children: [
          // AppHeader
          const AppHeader(title: "My Bag"),

          // Clear Bag Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onPressed: () async {
                    setState(() {
                      items.clear();
                    });
                    await _saveCartItems(); // localstorage update
                  },
                  child: const Text(
                    "Clear Bag",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Cart List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // Image
                        Image.network(
                          item.image,
                          width: 60,
                          height: 60,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/product.png",
                              width: 60,
                              height: 60,
                            );
                          },
                        ),

                        const SizedBox(width: 10),

                        // Item Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                                  Text(
      "ID: ${item.productId}",
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
      ),
    ),
                              const SizedBox(height: 6),
                              Text(
                                "৳ ${item.price} × ${item.qty} = ৳ ${(item.price * item.qty).toStringAsFixed(2)}",
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  // Delete Button
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () async {
                                      setState(() {
                                        items.removeAt(index);
                                      });
                                      await _saveCartItems(); // localstorage update
                                    },
                                  ),
                                  const Spacer(),
                                  // Quantity Controls
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: () async {
                                            setState(() {
                                              if (item.qty > 1) item.qty--;
                                            });
                                            await _saveCartItems(); // localstorage update
                                          },
                                        ),
                                        Text("${item.qty}"),
                                        IconButton(
                                          icon: const Icon(Icons.add, color: Colors.green),
                                          onPressed: () async {
                                            setState(() {
                                              item.qty++;
                                            });
                                            await _saveCartItems(); // localstorage update
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom Place Order Button
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
             // onPressed: () {},
              onPressed: () async {

  final prefs = await SharedPreferences.getInstance();
  String userToken = prefs.getString("token") ?? "";
  int userId = prefs.getInt("user_id") ?? 0;

  final orderItems = getOrderItems();

bool success = await OrderService().placeOrder(orderItems);

  if (success) {
     setState(() {
                      items.clear();
                    });
                    await _saveCartItems(); // localstorage update
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Order Successfully Placed")),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Order Failed")),
    );
  }
},
              child: Text(
                "Place Order : ৳ ${getTotal().toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}