//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../widget/TrendingProduct.dart';
// import '../../../widget/common/bottom_navigation_bar.dart';
// import '../../../widget/common/TopNavigationBar.dart';
// import '../../../provider/home_provider.dart';
//
// class TrendingProductListPage extends StatefulWidget {
//   const TrendingProductListPage({super.key});
//
//   @override
//   State<TrendingProductListPage> createState() => _TrendingProductListPageState();
// }
//
// class _TrendingProductListPageState extends State<TrendingProductListPage> {
//   TextEditingController searchController = TextEditingController();
//   List filteredProducts = [];
//
//   @override
//   void initState() {
//     super.initState();
//
//     Future.microtask(() {
//       context.read<HomeProvider>().getHomeData();
//     });
//   }
//   void searchProduct(String query, List products) {
//
//     final result = products.where((product) {
//       final name = product.name?.toLowerCase() ?? "";
//       return name.contains(query.toLowerCase());
//     }).toList();
//
//     setState(() {
//       filteredProducts = result;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     final provider = context.watch<HomeProvider>();
//     final trending = provider.homeData?.data?.trendingProducts ?? [];
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
//                 children: const [
//
//                   SizedBox(width: 5),
//
//                   Expanded(
//                     child:
//                     TextField(
//                       controller: searchController,
//                       onChanged: (value) {
//                         final provider = context.read<HomeProvider>();
//                         final products = provider.homeData?.data?.trendingProducts ?? [];
//                         searchProduct(value, products);
//                       },
//                       decoration: const InputDecoration(
//                         hintText: "Search by brand",
//                         border: InputBorder.none,
//                       ),
//                     )
//                   ),
//                 ],
//               ),
//             ),
//
//             /// Filter Row
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
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
//               child: provider.isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : ListView.builder(
//                 itemCount: trending.length,
//                 itemBuilder: (context, index) {
//
//                   final product = trending[index];
//                   itemCount: productsToShow.length,
//                   itemBuilder: (context, index) {
//
//                   final product = productsToShow[index];
//                   final productsToShow =
//                   filteredProducts.isNotEmpty ? filteredProducts : trending;
//
//                   return ProductCard(
//                   title: product.name ?? "",
//                   image: product.image ?? "",
//                   price: double.tryParse(product.sellingPrice ?? "0") ?? 0,
//                   oldPrice: double.tryParse(product.discountedPrice ?? "0") ?? 0,
//                   discount: double.parse(product.discountPercent ?? "0").toInt(),
//                   );
//                   },
//
//                   // return ProductCard(
//                   //   title: product.name ?? "",
//                   //   image: product.image ?? "",
//                   //   price: double.tryParse(product.sellingPrice ?? "0") ?? 0,
//                   //   oldPrice: double.tryParse(product.discountedPrice ?? "0") ?? 0,
//                   //   //discount: int.tryParse(product.discountPercent ?? "0") ?? 0,
//                   //   discount: double.parse(product.discountPercent ?? "0").toInt(),
//                   // );
//                 },
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
import '../widget/TrendingProduct.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/TopNavigationBar.dart';
import '../../../provider/home_provider.dart';

class TrendingProductListPage extends StatefulWidget {
  const TrendingProductListPage({super.key});

  @override
  State<TrendingProductListPage> createState() => _TrendingProductListPageState();
}

class _TrendingProductListPageState extends State<TrendingProductListPage> {
  TextEditingController searchController = TextEditingController();
  List filteredProducts = [];

  @override
  void initState() {
    super.initState();
    // হোম ডেটা লোড করা
    Future.microtask(() {
      context.read<HomeProvider>().getHomeData();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchProduct(String query, List products) {
    if (query.isEmpty) {
      setState(() {
        filteredProducts = [];
      });
      return;
    }

    final result = products.where((product) {
      final name = product.name?.toLowerCase() ?? "";
      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredProducts = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final trending = provider.homeData?.data?.trendingProducts ?? [];
    final productsToShow =
    filteredProducts.isNotEmpty ? filteredProducts : trending;

    return Scaffold(
      appBar: const AppHeader(title: "Trending Products"),
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
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        searchProduct(value, trending);
                      },
                      decoration: const InputDecoration(
                        hintText: "Search by brand",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Filter Row
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                  : productsToShow.isEmpty
                  ? const Center(child: Text("No products found"))
                  : ListView.builder(
                itemCount: productsToShow.length,
                itemBuilder: (context, index) {
                  final product = productsToShow[index];

                  return ProductCard(
                    title: product.name ?? "",
                    image: product.image ?? "",
                    price:
                    double.tryParse(product.sellingPrice ?? "0") ??
                        0,
                    oldPrice: double.tryParse(
                        product.discountedPrice ?? "0") ??
                        0,
                    discount: double.parse(
                        product.discountPercent ?? "0")
                        .toInt(),
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