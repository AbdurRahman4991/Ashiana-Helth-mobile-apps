import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../../../provider/home_provider.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/TopNavigationBar.dart';
import '../../../widget/common/drowerRight.dart';
import '../widget/TrendingProductCard.dart';
import '../widget/MenuFacturers.dart';
import '../../listpage/screens/TrendingProductList.dart';
import '../../listpage/screens/MenufacturersList.dart';
import '../../listpage/screens/NewProductListh.dart';
import '../../listpage/screens/CategoryList.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final ScrollController _trendingController = ScrollController();
  final ScrollController _menufacturersController = ScrollController();
  final ScrollController _newProductController = ScrollController();
  final ScrollController _categoriesController = ScrollController();
 


  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<HomeProvider>(context, listen: false).getHomeData();
    });
  }

  /// 🔄 Scroll functions
  void scrollLeft(ScrollController controller) {
    controller.animateTo(
      controller.offset - 220,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void scrollRight(ScrollController controller) {
    controller.animateTo(
      controller.offset + 220,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _trendingController.dispose();
    _menufacturersController.dispose();
    _newProductController.dispose();
    _categoriesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<HomeProvider>(context);
     final sliders = provider.homeData?.data?.sliders ?? [];

    return Scaffold(
      appBar: const AppHeader(title: ""),
      endDrawer: const DrowerRight(),
      bottomNavigationBar: const CustomBottomNav(),
      body: SafeArea(
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// 🔍 Search Bar
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.search, color: Colors.green),
                            SizedBox(width: 10),
                            Text(
                              "Search by brand, generic...",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// 🎯 Dynamic Banner Slider
CarouselSlider(
  options: CarouselOptions(
    height: 160,
    autoPlay: true,
    enlargeCenterPage: true,
    viewportFraction: 0.85,
  ),
  items: sliders.map((slider) {
    return bannerItem(slider.image ?? "");
  }).toList(),
),

                    const SizedBox(height: 20),

                    /// 🔥 Trending
                    sectionTitle(
                      Icons.local_fire_department,
                      "Trending",
                      "See all",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const TrendingProductListPage()),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    trendingProductSection(_trendingController),

                    const SizedBox(height: 20),

                    /// 🏭 Manufacturers
                    sectionTitle(
                      Icons.factory,
                      "Manufacturers",
                      "Discover all",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const MenufacturersListPage()),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    manufacturerSection(_menufacturersController),

                    const SizedBox(height: 20),

                    /// 🆕 New Products
                    sectionTitle(
                      Icons.fiber_new,
                      "New Products",
                      "See all",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const NewProductListPage()),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    newProductSection(_newProductController),

                    const SizedBox(height: 20),

                    /// 📦 Categories
                    sectionTitle(
                      Icons.category,
                      "Categories",
                      "Discover all",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CategoriListPage()),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    categorySection(_categoriesController),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
      ),
    );
  }

  /// 🔹 Banner Widget
  // Widget bannerItem(String image) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 5),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(12),
  //       image: DecorationImage(
  //         image: NetworkImage(image),
  //         fit: BoxFit.cover,
  //       ),
  //     ),
  //   );
  // }
  Widget bannerItem(String imageUrl) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
    ),
    child: CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => Container(
        color: Colors.grey.shade200,
        child: const Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey.shade200,
        child: const Icon(Icons.image_not_supported),
      ),
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    ),
  );
}

  /// 🔹 Trending Section (আগের মতো)
  Widget trendingProductSection(ScrollController controller) {
    return SizedBox(
      height: 270,
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return ProductCard(
            title: "Furoclav 250mg Tablet",
            price: 375,
            oldPrice: 500,
            discount: 25,
            image: "assets/product.png",
            outOfStock: true,
          );
        },
      ),
    );
  }

  /// 🔹 Manufacturer Section
  Widget manufacturerSection(ScrollController controller) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return const Menufacturers(
            image: "assets/menufacturers1.png",
          );
        },
      ),
    );
  }

  /// 🔹 New Product Section
  Widget newProductSection(ScrollController controller) {
    return SizedBox(
      height: 270,
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return ProductCard(
            title: "New Product ${index + 1}",
            price: 250,
            oldPrice: 300,
            discount: 15,
            image: "assets/newproduct3.jpg",
            outOfStock: false,
          );
        },
      ),
    );
  }

  /// 🔹 Category Section
  Widget categorySection(ScrollController controller) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return const Menufacturers(
            image: "assets/category3.png",
          );
        },
      ),
    );
  }

  /// 🔹 Section Title
  Widget sectionTitle(
    IconData icon,
    String title,
    String action, {
    VoidCallback? onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.orange),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          GestureDetector(
            onTap: onPressed,
            child: Text(
              action,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}