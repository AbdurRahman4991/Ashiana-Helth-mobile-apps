
import 'package:flutter/material.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/TopNavigationBar.dart';
import '../../../widget/common/drowerRight.dart';
import '../../models/order_model.dart';
import '../../core/services/my_order_sevice.dart';
import 'invoice_page.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: const AppHeader(title: "My Orders"),
      endDrawer: const DrowerRight(),
      bottomNavigationBar: const CustomBottomNav(),

      body: FutureBuilder<List<OrderModel>>(

        future: MyOrderService.fetchOrders(),

        builder: (context, snapshot) {

          /// Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          /// Error
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final orders = snapshot.data ?? [];

          /// Empty
          if (orders.isEmpty) {
            return const Center(
              child: Text("No orders found"),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),

            children: [

              /// Title
              const Text(
                "Invoices",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              /// Orders List
              ...orders.map((order) {

                return GestureDetector(

                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InvoicePage(orderId: order.id),
                      ),
                    );

                  },

                  child: Card(

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

                          /// Left Side
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                Text(
                                  "Invoice: ${order.id}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  "Created: ${order.createdAt}",
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

                          /// Right Side
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,

                            children: [

                              Text(
                                "৳ ${order.total.toStringAsFixed(2)}",
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

                              ),

                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                );

              }).toList(),

            ],
          );
        },
      ),
    );
  }
}