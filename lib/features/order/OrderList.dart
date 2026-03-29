
import 'package:flutter/material.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/TopNavigationBar.dart';
import '../../../widget/common/drowerRight.dart';
import '../../models/order_model.dart';
import '../../core/services/my_order_sevice.dart';
import 'invoice_page.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {

  late Future<List<OrderModel>> ordersFuture;

  @override
  void initState() {
    super.initState();

    /// ✅ ONLY ONE TIME API CALL
    ordersFuture = MyOrderService.fetchOrders();
  }

  /// 🔄 Refresh
  Future<void> refreshOrders() async {
    setState(() {
      ordersFuture = MyOrderService.fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: const AppHeader(title: ""),
      endDrawer: const DrowerRight(),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 3),

      body: FutureBuilder<List<OrderModel>>(
        future: ordersFuture, // ✅ FIX

        builder: (context, snapshot) {

          /// 🔄 Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          /// ❌ Error
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final orders = snapshot.data ?? [];

          /// 📭 Empty
          if (orders.isEmpty) {
            return const Center(child: Text("No orders found"));
          }

          /// 📋 List
          return RefreshIndicator(
            onRefresh: refreshOrders,

            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [

                const Text(
                  "Invoices",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                ...orders.map((order) {

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              InvoicePage(orderId: order.id),
                        ),
                      );
                    },

                    child: Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(16),

                        child: Row(
                          children: [

                            /// LEFT
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    "Invoice: ${order.id}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Text("Created: ${order.createdAt}"),

                                  const SizedBox(height: 6),

                                  Text("Status: ${order.status}"),
                                ],
                              ),
                            ),

                            /// RIGHT
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.end,
                              children: [

                                Text(
                                  "৳ ${order.total.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius:
                                    BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    order.status,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}