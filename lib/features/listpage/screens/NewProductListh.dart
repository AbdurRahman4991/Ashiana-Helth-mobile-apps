import 'package:flutter/material.dart';
import '../widget/NewProduct.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/TopNavigationBar.dart';

class NewProductListPage extends StatelessWidget {
  const NewProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: ""),
      bottomNavigationBar: const CustomBottomNav(),
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Column(
          children: [

            /// Search Header
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 5,
                  )
                ],
              ),
              child: Row(
                children: [
                
                  const SizedBox(width: 5),

                  /// Search Field
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search by product",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Filter Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.filter_alt_outlined, color: Colors.green),
                  SizedBox(width: 10),
                  Icon(Icons.list),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// Product List
            Expanded(
              child: ListView(
                children: const [
                   NewProduct(),
                  NewProduct(),
                  NewProduct(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}