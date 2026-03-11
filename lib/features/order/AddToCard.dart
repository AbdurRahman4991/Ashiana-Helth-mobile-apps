

import 'package:flutter/material.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/TopNavigationBar.dart';
import '../../../widget/common/drowerRight.dart';
import '../../core/storage/local_storage.dart';


class CartItem {
  String name;
  double price;
  int qty;
  String image;

  CartItem({
    required this.name,
    required this.price,
    required this.qty,
    required this.image,
  });
}

class BagPage extends StatefulWidget {
  const BagPage({super.key});

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  List<CartItem> items = [
    CartItem(
      name: "Oral Solution Alcet 60ml 2.5 mg/5 ml",
      price: 42.5,
      qty: 1,
      image: "assets/product.png",
    ),
    CartItem(
      name: "Tablet Kefuclav 250mg+62.5mg (16 Pcs)",
      price: 481.6,
      qty: 1,
      image: "assets/product.png",
    ),
    CartItem(
      name: "Tablet Furoclav 250mg (14 pcs)",
      price: 411.6,
      qty: 1,
      image: "assets/product.png",
    ),
  ];

  double getTotal() {
    double total = 0;
    for (var item in items) {
      total += item.price * item.qty;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      endDrawer: const DrowerRight(),
      bottomNavigationBar: const CustomBottomNav(),
      body: Column(
        children: [

          // ১. AppHeader
          const AppHeader(title: ""),

          // ২. Clear Bag Button
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end, // ডানদিকে রাখবে
    children: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
        //  backgroundColor: Colors.white, // বাটনের ব্যাকগ্রাউন্ড চাইলে দিন
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        onPressed: () {
          setState(() {
            items.clear();
          });
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

          // ৩. Cart List
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
                        Image.asset(
                          item.image,
                          width: 60,
                          height: 60,
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
                                    onPressed: () {
                                      setState(() {
                                        items.removeAt(index);
                                      });
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
                                          onPressed: () {
                                            setState(() {
                                              if (item.qty > 1) item.qty--;
                                            });
                                          },
                                        ),

                                        Text("${item.qty}"),

                                        IconButton(
                                          icon: const Icon(Icons.add, color: Colors.green),
                                          onPressed: () {
                                            setState(() {
                                              item.qty++;
                                            });
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

          // ৪. Bottom Place Order Button
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {},
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