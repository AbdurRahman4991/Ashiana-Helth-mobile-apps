import 'package:flutter/material.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/TopNavigationBar.dart';
import '../../../widget/common/drowerRight.dart';

class Order {
  final int invoice;
  final String date;
  final double amount;
  final String status;

  Order({
    required this.invoice,
    required this.date,
    required this.amount,
    required this.status,
  });
}

class OrdersPage extends StatelessWidget {
  OrdersPage({super.key});

  final List<Order> orders = [
    Order(
      invoice: 754,
      date: "06 Mar, 2026, 03:00 PM",
      amount: 361.00,
      status: "Processing",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      appBar: const AppHeader(title: ""),
      endDrawer: const DrowerRight(),
      bottomNavigationBar: const CustomBottomNav(),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// Pending Orders
          const Text(
            "Pending Orders",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text("No pending orders."),

          const Divider(height: 30),

          /// Invoice Title
          const Text(
            "Invoices",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          /// Invoice List
          ...orders.map((order) {

            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),

              margin: const EdgeInsets.only(bottom: 12),

              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Invoice: ${order.invoice}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            "Created: ${order.date}",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Row(
                            children: [

                              const Text("Status: "),

                              Text(
                                order.status,
                                style: const TextStyle(
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        Text(
                          "৳ ${order.amount.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            order.status,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        )

                      ],
                    )

                  ],
                ),
              ),
            );

          }).toList(),

        ],
      ),
    );
  }
}