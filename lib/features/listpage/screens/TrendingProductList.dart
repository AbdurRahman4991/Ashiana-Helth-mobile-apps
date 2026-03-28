
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/TrendingProduct.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/TopNavigationBar.dart';
import '../../../widget/common/drowerRight.dart';
import '../../../provider/TrendingProvider.dart';


class TrendingProductListPage extends StatefulWidget {
  const TrendingProductListPage({super.key});

  @override
  State<TrendingProductListPage> createState() =>
      _TrendingProductListPageState();
}

class _TrendingProductListPageState
    extends State<TrendingProductListPage> {

  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  List filteredProducts = [];

  @override
  void initState() {
    super.initState();

    final provider = context.read<TrendingProvider>();
    if (provider.products.isEmpty) { // ✅ prevent multiple API call
      provider.fetchTrending();
    }
    //provider.fetchTrending();

    /// 🔥 Infinite Scroll Listener
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        provider.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  /// 🔍 Search Function
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
    final provider = context.watch<TrendingProvider>();

    final productsToShow =
    filteredProducts.isNotEmpty ? filteredProducts : provider.products;

    return Scaffold(
      appBar: const AppHeader(title: ""),
      endDrawer: const DrowerRight(),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
      backgroundColor: const Color(0xffF5F5F5),

      body: Column(
        children: [

          /// 🔍 Search Box
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
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                searchProduct(value, provider.products);
              },
              decoration: const InputDecoration(
                hintText: "Search product",
                border: InputBorder.none,
              ),
            ),
          ),

          /// 🛒 Product List
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : productsToShow.isEmpty
                ? const Center(child: Text("No products found"))
                : ListView.builder(
              controller: _scrollController,
              itemCount: productsToShow.length +
                  (provider.isLoadMore ? 1 : 0),
              itemBuilder: (context, index) {

                /// 🔄 Load More Loader
                if (index == productsToShow.length) {
                  return const Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final product = productsToShow[index];

                return ProductCardList(
                  id: product.id,
                  title: product.name ?? "",
                  image: product.image ?? "",
                  price: product.sellingPrice ?? 0,
                  oldPrice: product.discountedPrice ?? 0,
                  discount:
                  (product.discountPercent ?? 0).toInt(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}