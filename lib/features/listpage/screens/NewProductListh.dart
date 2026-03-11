// import 'package:flutter/material.dart';
// import '../widget/NewProduct.dart';
// import '../../../widget/common/bottom_navigation_bar.dart';
// import '../../../widget/common/TopNavigationBar.dart';
//
// class NewProductListPage extends StatelessWidget {
//   const NewProductListPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
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
//
//                   const SizedBox(width: 5),
//
//                   /// Search Field
//                   const Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: "Search by product",
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
//                   NewProduct(),
//                   NewProduct(),
//                   NewProduct(),
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
import '../widget/NewProduct.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/TopNavigationBar.dart';
import '../../../provider/new_product_provider.dart';


class NewProductListPage extends StatefulWidget {
  const NewProductListPage({super.key});

  @override
  State<NewProductListPage> createState() => _NewProductListPageState();
}

class _NewProductListPageState extends State<NewProductListPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<NewProductProvider>(context, listen: false)
          .fetchNewProducts();
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<NewProductProvider>(context);

    return Scaffold(
      appBar: const AppHeader(title: "New Products"),
      bottomNavigationBar: const CustomBottomNav(),
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : provider.products.isEmpty
            ? const Center(child: Text("No new products found"))
            : ListView.builder(
          itemCount: provider.products.length,
          itemBuilder: (context, index) {
            return NewProduct(product: provider.products[index]);
          },
        ),
      ),
    );
  }
}
