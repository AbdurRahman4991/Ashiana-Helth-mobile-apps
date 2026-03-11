// import 'package:flutter/material.dart';
// import '../widget/Categories.dart';
// import '../../../widget/common/bottom_navigation_bar.dart';
// import '../../../widget/common/TopNavigationBar.dart';
//
// class CategoriListPage extends StatelessWidget {
//   final int categoriesId;
//   const CategoriListPage({super.key, required this.categoriesId});
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: const AppHeader(title: ""),
//       bottomNavigationBar: const CustomBottomNav(),
//       backgroundColor: const Color(0xffF5F5F5),
//       body: SafeArea(
//         child: Column(
//           children: [
//
//             /// Search Header
//             Container(
//               margin: const EdgeInsets.all(12),
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.shade200,
//                     blurRadius: 5,
//                   )
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   const SizedBox(width: 5),
//
//                   /// Search Field
//                   const Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: "Search by categori",
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             /// Filter Row
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: const [
//                   Icon(Icons.filter_alt_outlined, color: Colors.green),
//                   SizedBox(width: 10),
//                   Icon(Icons.list),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             /// Product List
//             Expanded(
//               child: ListView(
//                 children: const [
//                   Categories(),
//                   Categories(),
//                   Categories(),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/Categories.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/TopNavigationBar.dart';
import '../../../provider/category_product_provider.dart';

class CategoriListPage extends StatefulWidget {

  final int categoriesId;

  const CategoriListPage({
    super.key,
    required this.categoriesId,
  });

  @override
  State<CategoriListPage> createState() => _CategoriListPageState();
}

class _CategoriListPageState extends State<CategoriListPage> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<CategoryProductProvider>(context, listen: false)
          .fetchProducts(widget.categoriesId);
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<CategoryProductProvider>(context);

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
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  const SizedBox(width: 5),

                  /// Search Field
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search by category",
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
              child: provider.isLoading
                  ? const Center(child: CircularProgressIndicator())

                  : provider.products.isEmpty
                  ? const Center(child: Text("No products found"))

                  : ListView.builder(
                itemCount: provider.products.length,
                itemBuilder: (context, index) {

                  final product = provider.products[index];

                  return Categories(product: product);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}