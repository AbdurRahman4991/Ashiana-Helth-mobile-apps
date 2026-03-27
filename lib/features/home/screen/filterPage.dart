
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/FilterProvider.dart';
import '../../listpage/widget/NewProduct.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/drowerRight.dart';

// class FilterPage extends StatefulWidget {
//   final String searchText;

//   const FilterPage({super.key, required this.searchText});

//   @override
//   State<FilterPage> createState() => _FilterPageState();
// }

// class _FilterPageState extends State<FilterPage> {
//   late TextEditingController controller;

//   @override
//   void initState() {
//     super.initState();

//     controller = TextEditingController(text: widget.searchText);

//     Future.microtask(() {
//       Provider.of<SearchProvider>(context, listen: false)
//           .search(widget.searchText);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<SearchProvider>(context);

//     return Scaffold(
//      // appBar: const AppHeader(title: ""),
//       endDrawer: const DrowerRight(),
//       bottomNavigationBar: const CustomBottomNav(currentIndex: 1),

//       appBar: AppBar(
//         title: TextField(
//           controller: controller,
//           decoration: const InputDecoration(
//             hintText: "Search medicine...",
//             border: InputBorder.none,
//           ),
//           onChanged: (value) {
//             provider.search(value);
//           },
//         ),
//       ),
//       body: provider.isLoading
//           ? const Center(child: CircularProgressIndicator())

//           /// if product is not
//           : provider.products.isEmpty
//               ? const Center(
//                   child: Text(
//                     "No products found",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 )

//               /// Product List
//               : ListView.builder(
//                   padding: const EdgeInsets.symmetric(vertical: 8),
//                   itemCount: provider.products.length,
//                   itemBuilder: (context, index) {
//                     final product = provider.products[index];

//                     return NewProduct(product: product);
//                   },
//                 ),
//     );
//   }
// }
class FilterPage extends StatefulWidget {
  final List<int> categoryIds;
  final List<int> companyIds;
  final String searchText;

  const FilterPage({
    super.key,
    required this.categoryIds,
    required this.companyIds,
    required this.searchText,
  });

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.searchText);

    Future.microtask(() {
      Provider.of<FilterProvider>(context, listen: false).filter(
        categoryIds: widget.categoryIds,
        companyIds: widget.companyIds,
        search: widget.searchText,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FilterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Search medicine...",
            border: InputBorder.none,
          ),
          onChanged: (value) {
            provider.filter(
              categoryIds: widget.categoryIds,
              companyIds: widget.companyIds,
              search: value,
            );
          },
        ),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.products.isEmpty
              ? const Center(child: Text("No products found"))
              : ListView.builder(
                  itemCount: provider.products.length,
                  itemBuilder: (context, index) {
                    final product = provider.products[index];
                    return NewProduct(product: product);
                  },
                ),
    );
  }
}