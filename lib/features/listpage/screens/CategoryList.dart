import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/Categories.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/drowerRight.dart';
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
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<CategoryProductProvider>(context, listen: false)
          .fetchProducts(widget.categoriesId);
    });

    _scrollController.addListener(() {
      final provider = Provider.of<CategoryProductProvider>(context, listen: false);

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        provider.loadMore(widget.categoriesId);
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProductProvider>(context);

    return Scaffold(
      appBar: const AppHeader(title: ""),
      endDrawer: const DrowerRight(),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
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
                boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  if (value.length >= 3) {
                    provider.searchProducts(value, widget.categoriesId);
                  } else if (value.isEmpty) {
                    provider.fetchProducts(widget.categoriesId);
                  }
                },
                decoration: const InputDecoration(
                  hintText: "Search by category",
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// Product List
            Expanded(
              child: provider.isLoading && provider.products.isEmpty
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

                  return Categories(product: product);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _CategoriListPageState extends State<CategoriListPage> {
//   TextEditingController searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//
//     Future.microtask(() {
//       Provider.of<CategoryProductProvider>(context, listen: false)
//           .fetchProducts(widget.categoriesId);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     final provider = Provider.of<CategoryProductProvider>(context);
//
//     return Scaffold(
//       appBar: const AppHeader(title: ""),
//       endDrawer: const DrowerRight(),
//       bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
//       backgroundColor: const Color(0xffF5F5F5),
//
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
//                   // IconButton(
//                   //   icon: const Icon(Icons.arrow_back),
//                   //   onPressed: () {
//                   //     Navigator.pop(context);
//                   //   },
//                   // ),
//
//                   const SizedBox(width: 5),
//
//                   /// Search Field
//
//                   Expanded(
//                     child: TextField(
//                       controller: searchController,
//                       onChanged: (value) {
//                         if (value.length >= 3) {
//                           Provider.of<CategoryProductProvider>(context, listen: false)
//                               .searchProducts(value, widget.categoriesId);
//                         } else if (value.isEmpty) {
//                           Provider.of<CategoryProductProvider>(context, listen: false)
//                               .fetchProducts(widget.categoriesId);
//                         }
//                       },
//                       decoration: const InputDecoration(
//                         hintText: "Search by category",
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
//                 // children: const [
//                 //   Icon(Icons.filter_alt_outlined, color: Colors.green),
//                 //   SizedBox(width: 10),
//                 //   Icon(Icons.list),
//                 // ],
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             /// Product List
//             Expanded(
//               child: provider.isLoading
//                   ? const Center(child: CircularProgressIndicator())
//
//                   : provider.products.isEmpty
//                   ? const Center(child: Text("No products found"))
//
//                   : ListView.builder(
//                 itemCount: provider.products.length,
//                 itemBuilder: (context, index) {
//
//                   final product = provider.products[index];
//
//                   return Categories(product: product);
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }