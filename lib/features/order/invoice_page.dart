import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../provider/order_detail_provider.dart';
import '../../models/order_model.dart';
import '../../provider/invoice_provider.dart';

import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ashianahealth_mobile_app/main.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/TopNavigationBar.dart';
import '../../../widget/common/drowerRight.dart';


class InvoicePage extends StatelessWidget {
  final int orderId; // Required to fetch order
  const InvoicePage({super.key, required this.orderId});

  String formatDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    return DateFormat('dd MMM, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    // Fetch order details when page opens
    final provider = Provider.of<OrderDetailProvider>(context, listen: false);
    provider.fetchOrder(orderId);

    return Scaffold(
      appBar: const AppHeader(title: ""),
      endDrawer: const DrowerRight(),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
      body: Consumer<OrderDetailProvider>(
        builder: (context, provider, _) {
          if (provider.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final order = provider.order;
          if (order == null) {
            return const Center(child: Text("Failed to load order details"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Invoice Details
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        rowItem("Invoice ID", order.id.toString()),
                        rowItem("Status", order.status),
                        rowItem("Date", formatDate(order.createdAt)),
                        rowItem("Total", "৳${order.total.toStringAsFixed(2)}"),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Ordered Items
                const Text(
                  "Ordered Items",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ...order.orderItems.map((item) => itemCard(item)).toList(),


                const SizedBox(height: 20),

                /// Summary
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Order Summary",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        summaryRow("Amount", "৳${order.total.toStringAsFixed(2)}"),
                        summaryRow("Discount", "৳0.00"),
                        const Divider(),
                        summaryRow("Grand Total", "৳${order.total.toStringAsFixed(2)}", isBold: true),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: Consumer<InvoiceProvider>(
                    builder: (context, provider, _) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: provider.isLoading
                            ? null
                            : () async {
                          final bytes = await provider.downloadInvoice(orderId);
                          if (bytes != null) {
                            final dir = await getApplicationDocumentsDirectory();
                            final file = File("${dir.path}/invoice_$orderId.pdf");
                            await file.writeAsBytes(bytes);
                            OpenFile.open(file.path);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Failed to download invoice"),
                              ),
                            );
                          }
                        },
                        child: provider.isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Download Invoice"),
                      );
                    },
                  ),
                ),

                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.green,
                //       padding: const EdgeInsets.symmetric(vertical: 14),
                //     ),
                //     onPressed: () {
                //       print("Download Invoice");
                //     },
                //     child: const Text("Download Invoice"),
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Invoice Row Widget
  Widget rowItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  /// Order Item Card Widget
  Widget itemCard(OrderItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [

            /// Product Image
            // Container(
            //   width: 60,
            //   height: 60,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(8),
            //     image: DecorationImage(
            //       image: NetworkImage(
            //           "https://demoapp.ashianahealth.com/storage/products/${item.product?.image ?? 'default.png'}"),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl:
                  "https://demoapp.ashianahealth.com/storage/products/${item.product?.image ?? 'default.png'}",
                  cacheManager: MyCacheManager.instance,
                  fit: BoxFit.cover,

                  placeholder: (context, url) => Container(
                    color: Colors.grey.shade300,
                  ),

                  errorWidget: (context, url, error) =>
                      Image.asset("assets/product.png", fit: BoxFit.cover),
                ),
              ),
            ),

            const SizedBox(width: 12),

            /// Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product?.name ?? "Unknown Product",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text("Qty: ${item.qty}", style: const TextStyle(color: Colors.grey)),
                  Text("Price: ৳${item.discountedPrice.toStringAsFixed(2)}", style: const TextStyle(color: Colors.black87)),
                ],
              ),
            ),

            /// Price Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "৳${item.sellingPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "৳${item.discountedPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Summary Row Widget
  Widget summaryRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );

  }


}