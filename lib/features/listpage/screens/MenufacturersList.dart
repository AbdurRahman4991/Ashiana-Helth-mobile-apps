import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/drowerRight.dart';
import '../../../widget/common/TopNavigationBar.dart';
import '../../../provider/product_provider.dart';
import '../widget/Menufacturers.dart';


class MenufacturersListPage extends StatefulWidget {
  final int manufacturerId;

  const MenufacturersListPage({super.key, required this.manufacturerId});

  @override
  State<MenufacturersListPage> createState() => _MenufacturersListPageState();
}

// class _MenufacturersListPageState extends State<MenufacturersListPage> {
//
//   @override
//   void initState() {
//     super.initState();
//
//     Future.microtask(() {
//       Provider.of<ProductProvider>(context, listen: false)
//           .fetchProductsByManufacturer(widget.manufacturerId);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     final provider = Provider.of<ProductProvider>(context);
//
//     return Scaffold(
//       appBar: const AppHeader(title: ""),
//       endDrawer: const DrowerRight(),
//       bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
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
//               child: const Row(
//                 children: [
//                   SizedBox(width: 5),
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: "Search by menufactures",
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             /// Filter Row
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 12),
//               // child: Row(
//               //   mainAxisAlignment: MainAxisAlignment.end,
//               //   children: [
//               //     Icon(Icons.filter_alt_outlined, color: Colors.green),
//               //     SizedBox(width: 10),
//               //     Icon(Icons.list),
//               //   ],
//               // ),
//             ),
//
//             const SizedBox(height: 10),
//
//             /// Product List
//             Expanded(
//               child: provider.loading
//                   ? const Center(child: CircularProgressIndicator())
//                   : ListView.builder(
//                       itemCount: provider.products.length,
//                       itemBuilder: (context, index) {
//
//                         final product = provider.products[index];
//
//                         return Menufacturers(
//                           id: product.id,
//                           image: product.image,
//                           name: product.name,
//                           manufacturerName: product.manufacturing?.name ?? "",
//                           sellingPrice: product.sellingPrice,
//                           discountedPrice: product.discountedPrice,
//                           discountPercent: product.discountPercent,
//                          // outOfStock: product.outOfStock ?? false,
//                         );
//                       },
//                     ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
class _MenufacturersListPageState extends State<MenufacturersListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<ProductProvider>(context, listen: false)
          .fetchProductsByManufacturer(widget.manufacturerId);
    });

    /// 🔄 Infinite scroll
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        Provider.of<ProductProvider>(context, listen: false)
            .loadMore(widget.manufacturerId);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: const AppHeader(title: ""),
      endDrawer: const DrowerRight(),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            /// Search box (optional)
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade200, blurRadius: 5),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search by manufacturers",
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// Product List
            Expanded(
              child: provider.loading && provider.products.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                controller: _scrollController,
                itemCount: provider.products.length + (provider.isLoadMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == provider.products.length) {
                    return const Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final product = provider.products[index];

                  return Menufacturers(
                    id: product.id,
                    image: product.image,
                    name: product.name,
                    manufacturerName: product.manufacturing?.name ?? "",
                    sellingPrice: product.sellingPrice,
                    discountedPrice: product.discountedPrice,
                    discountPercent: product.discountPercent,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}