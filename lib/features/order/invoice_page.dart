import 'package:flutter/material.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Invoice Details
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    rowItem("Invoice ID", "754"),
                    rowItem("Invoice Status", "Processing"),
                    rowItem("Date", "06 Mar, 2026"),
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

            itemCard(),

            const SizedBox(height: 20),

            /// Delivered Items
            const Text(
              "Delivered Items",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            itemCard(),

            const SizedBox(height: 20),

            /// Summary
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [

                    const Text(
                      "Order vs Delivery Summary",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 20),

                    summaryRow("Amount", "৳420.00", "৳420.00"),
                    summaryRow("Discount", "-৳58.80", "-৳58.80"),

                    const Divider(),

                    summaryRow(
                        "Grand Total", "৳361.20", "৳361.20",
                        isBold: true),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Invoice Row
  Widget rowItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  /// Product Item Card
  Widget itemCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [

            /// Image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: NetworkImage(
                      "https://via.placeholder.com/150"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 10),

            /// Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Linstar M - 2.5/850 mg",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text("Qty: 1"),
                ],
              ),
            ),

            /// Price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  "৳420.00",
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey),
                ),
                SizedBox(height: 5),
                Text(
                  "৳361.20",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  /// Summary Row
  Widget summaryRow(String title, String order, String delivery,
      {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Row(
            children: [
              SizedBox(
                  width: 90,
                  child: Text(order,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontWeight:
                          isBold ? FontWeight.bold : FontWeight.normal))),
              const SizedBox(width: 20),
              SizedBox(
                  width: 90,
                  child: Text(delivery,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontWeight:
                          isBold ? FontWeight.bold : FontWeight.normal))),
            ],
          )
        ],
      ),
    );
  }
}