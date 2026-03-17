
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
