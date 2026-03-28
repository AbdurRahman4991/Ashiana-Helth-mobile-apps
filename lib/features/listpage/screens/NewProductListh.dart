
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/NewProduct.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/drowerRight.dart';
import '../../../widget/common/TopNavigationBar.dart';
import '../../../provider/new_product_provider.dart';


class NewProductListPage extends StatefulWidget {
  const NewProductListPage({super.key});

  @override
  State<NewProductListPage> createState() => _NewProductListPageState();
}
class _NewProductListPageState extends State<NewProductListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final provider =
        Provider.of<NewProductProvider>(context, listen: false);

    // Future.microtask(() {
    //   provider.fetchNewProducts();
    // });
    if (provider.products.isEmpty) { // ✅ prevent duplicate call
      provider.fetchNewProducts();
    }
    /// 🔥 Scroll Listener
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        provider.loadMore();
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
    final provider = Provider.of<NewProductProvider>(context);

    return Scaffold(
      appBar: const AppHeader(title: ""),
      endDrawer: const DrowerRight(),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
      backgroundColor: const Color(0xffF5F5F5),

      body: SafeArea(
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : provider.products.isEmpty
                ? const Center(child: Text("No new products found"))
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: provider.products.length + 1,
                    itemBuilder: (context, index) {
                      /// Product item
                      if (index < provider.products.length) {
                        return NewProduct(
                            product: provider.products[index]);
                      }

                      /// 🔥 Load More Indicator
                      return provider.isLoadMore
                          ? const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(
                                  child: CircularProgressIndicator()),
                            )
                          : const SizedBox();
                    },
                  ),
      ),
    );
  }
}

