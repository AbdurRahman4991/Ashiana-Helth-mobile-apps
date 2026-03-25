
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/search_provider.dart';
import '../../listpage/widget/NewProduct.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/TopNavigationBar.dart';
import '../../../widget/common/drowerRight.dart';

class SearchPage extends StatefulWidget {
  final String searchText;

  const SearchPage({super.key, required this.searchText});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.searchText);

    Future.microtask(() {
      Provider.of<SearchProvider>(context, listen: false)
          .search(widget.searchText);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context);

    return Scaffold(
     // appBar: const AppHeader(title: ""),
      endDrawer: const DrowerRight(),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 1),

      appBar: AppBar(
        title: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Search medicine...",
            border: InputBorder.none,
          ),
          onChanged: (value) {
            provider.search(value);
          },
        ),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())

          /// যদি কোনো product না থাকে
          : provider.products.isEmpty
              ? const Center(
                  child: Text(
                    "No products found",
                    style: TextStyle(fontSize: 16),
                  ),
                )

              /// Product List
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: provider.products.length,
                  itemBuilder: (context, index) {
                    final product = provider.products[index];

                    return NewProduct(product: product);
                  },
                ),
    );
  }
}