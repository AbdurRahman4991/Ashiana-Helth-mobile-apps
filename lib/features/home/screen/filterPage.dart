
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../provider/FilterProvider.dart';
// import '../../listpage/widget/NewProduct.dart';
// import '../../../widget/common/bottom_navigation_bar.dart';
// import '../../../widget/common/drowerRight.dart';
//
//
// class FilterPage extends StatefulWidget {
//   final List<int> categoryIds;
//   final List<int> companyIds;
//   final String searchText;
//
//   const FilterPage({
//     super.key,
//     required this.categoryIds,
//     required this.companyIds,
//     required this.searchText,
//   });
//
//   @override
//   State<FilterPage> createState() => _FilterPageState();
// }
//
// class _FilterPageState extends State<FilterPage> {
//   late TextEditingController controller;
//   late ScrollController scrollController;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = TextEditingController(text: widget.searchText);
//     scrollController = ScrollController();
//
//     final provider = Provider.of<FilterProvider>(context, listen: false);
//
//     Future.microtask(() {
//       provider.filter(
//         categoryIds: widget.categoryIds,
//         companyIds: widget.companyIds,
//         search: widget.searchText,
//       );
//     });
//
//     scrollController.addListener(() {
//       if (scrollController.position.pixels >=
//           scrollController.position.maxScrollExtent - 200 &&
//           !provider.isLoadingMore &&
//           provider.currentPage < provider.lastPage) {
//         provider.loadMore(
//           categoryIds: widget.categoryIds,
//           companyIds: widget.companyIds,
//           search: controller.text,
//         );
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<FilterProvider>(context);
//
//     return Scaffold(
//
//       endDrawer: const DrowerRight(),
//       bottomNavigationBar: CustomBottomNav(currentIndex: 0),
//       appBar: AppBar(
//         title: TextField(
//           controller: controller,
//           decoration: const InputDecoration(
//             hintText: "Search medicine...",
//             border: InputBorder.none,
//           ),
//           onChanged: (value) {
//             provider.filter(
//               categoryIds: widget.categoryIds,
//               companyIds: widget.companyIds,
//               search: value,
//             );
//           },
//         ),
//       ),
//       body: provider.isLoading && provider.products.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         controller: scrollController,
//         itemCount: provider.products.length + 1,
//         itemBuilder: (context, index) {
//           if (index < provider.products.length) {
//             return NewProduct(product: provider.products[index]);
//           } else {
//             return provider.isLoadingMore
//                 ? const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Center(child: CircularProgressIndicator()),
//             )
//                 : const SizedBox.shrink();
//           }
//         },
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/FilterProvider.dart';

import '../../listpage/widget/NewProduct.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/drowerRight.dart';

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
  late ScrollController scrollController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.searchText);
    scrollController = ScrollController();

    final provider = Provider.of<FilterProvider>(context, listen: false);

    /// Initial Load
    Future.microtask(() {
      provider.filter(
        categoryIds: widget.categoryIds,
        companyIds: widget.companyIds,
        //search: widget.searchText,
      );
    });

    /// Infinite Scroll
    scrollController.addListener(() {
      final provider = Provider.of<FilterProvider>(context, listen: false);

      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200 &&
          !provider.isLoadingMore &&
          provider.currentPage < provider.lastPage) {

        provider.loadMore(
          categoryIds: widget.categoryIds,
          companyIds: widget.companyIds,
        );
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FilterProvider>(context);

    return Scaffold(
      endDrawer: const DrowerRight(),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 0),

      /// 🔍 Search Bar
      appBar: AppBar(
        title: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Search medicine...",
            border: InputBorder.none,
          ),
            onChanged: (value) {
              provider.searchLocal(value); // 🔥 local search
            }
          // onChanged: (value) {
          //   if (_debounce?.isActive ?? false) _debounce!.cancel();
          //
          //   _debounce = Timer(const Duration(milliseconds: 500), () {
          //     provider.filter(
          //       categoryIds: widget.categoryIds,
          //       companyIds: widget.companyIds,
          //       search: value,
          //     );
          //   });
          // },
        ),
      ),

      /// 📦 Product List
      body: provider.isLoading && provider.products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : provider.products.isEmpty
          ? const Center(child: Text("No products found"))
          : ListView.builder(
        controller: scrollController,
          itemCount: provider.filteredProducts.length + 1,
          itemBuilder: (context, index) {
            if (index < provider.filteredProducts.length) {
              return NewProduct(
                product: provider.filteredProducts[index],
              );
            } else {
              return provider.isLoadingMore
                  ? const Padding(
                padding: EdgeInsets.all(10),
                child: Center(child: CircularProgressIndicator()),
              )
                  : const SizedBox();
            }
          }
        // itemCount: provider.products.length + 1,
        // itemBuilder: (context, index) {
        //   if (index < provider.products.length) {
        //     return NewProduct(
        //         product: provider.products[index]);
        //   } else {
        //     return provider.isLoadingMore
        //         ? const Padding(
        //       padding: EdgeInsets.all(10),
        //       child: Center(
        //           child: CircularProgressIndicator()),
        //     )
        //         : const SizedBox();
        //   }
        // },
      ),
    );
  }
}

// class _FilterPageState extends State<FilterPage> {
//   late TextEditingController controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     controller = TextEditingController(text: widget.searchText);
//
//     Future.microtask(() {
//       Provider.of<FilterProvider>(context, listen: false).filter(
//         categoryIds: widget.categoryIds,
//         companyIds: widget.companyIds,
//         search: widget.searchText,
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<FilterProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
//           controller: controller,
//           decoration: const InputDecoration(
//             hintText: "Search medicine...",
//             border: InputBorder.none,
//           ),
//           onChanged: (value) {
//             provider.filter(
//               categoryIds: widget.categoryIds,
//               companyIds: widget.companyIds,
//               search: value,
//             );
//           },
//         ),
//       ),
//       body: provider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : provider.products.isEmpty
//               ? const Center(child: Text("No products found"))
//               : ListView.builder(
//                   itemCount: provider.products.length,
//                   itemBuilder: (context, index) {
//                     final product = provider.products[index];
//                     return NewProduct(product: product);
//                   },
//                 ),
//     );
//   }
// }