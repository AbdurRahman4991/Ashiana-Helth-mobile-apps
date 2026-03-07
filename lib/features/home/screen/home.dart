import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/TopNavigationBar.dart';
import '../../../widget/common/drowerRight.dart';
import '../widget/TrendingProductCard.dart';
import '../widget/MenuFacturers.dart';
import '../../listpage/screens/TrendingProductList.dart';
import '../../listpage/screens/MenufacturersList.dart';
import '../../listpage/screens/NewProductListh.dart';
import '../../listpage/screens/CategoryList.dart';


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
    return Scaffold(
      appBar: const AppHeader(title: ""),
      endDrawer: const DrowerRight(),
      bottomNavigationBar: const CustomBottomNav(),
      body: SafeArea(
        child: SingleChildScrollView(
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

              /// 🎯 Banner Slider
              CarouselSlider(
                options: CarouselOptions(
                  height: 160,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.85,
                ),
                items: [
                  bannerItem("assets/banner1.jpg"),
                  bannerItem("assets/banner2.jpg"),
                ],
              ),

              const SizedBox(height: 20),

              /// 🔥 Trending Section
              /// 🔥 Trending Section
              sectionTitle(
                Icons.local_fire_department,
                "Trending",
                "See all",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TrendingProductListPage()),
                  );
                },
              ),
              const SizedBox(height: 10),
              trendingProductSection(_trendingController),

              const SizedBox(height: 20),

              /// 🏭 Manufacturers Section
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
              /// 🆕 New Products
              sectionTitle(
                Icons.fiber_new,
                "New Products",
                "See all",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NewProductListPage()),
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
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_)=> const CategoriListPage()),
                    
                    );
                }
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

  /// 🔹 Trending Product Section
Widget trendingProductSection(ScrollController controller) {
  return SizedBox(
    height: 270,
    child: Stack(
      children: [
        ListView.builder(
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
        Positioned(
          left: 0,
          top: 100,
          child: arrowButton(onTap: () => scrollLeft(controller), isLeft: true),
        ),
        Positioned(
          right: 0,
          top: 100,
          child: arrowButton(onTap: () => scrollRight(controller), isLeft: false),
        ),
      ],
    ),
  );
}

/// 🔹 New Product Section
Widget newProductSection(ScrollController controller) {
  return SizedBox(
    height: 270,
    child: Stack(
      children: [
        ListView.builder(
          controller: controller,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 5,
          itemBuilder: (context, index) {
            return ProductCard(
              title: "New Product ${index + 1}",
              price: 250 + index * 50,
              oldPrice: 300 + index * 50,
              discount: 15,
              image: "assets/newproduct3.jpg",
              outOfStock: false,
            );
          },
        ),
        Positioned(
          left: 0,
          top: 100,
          child: arrowButton(onTap: () => scrollLeft(controller), isLeft: true),
        ),
        Positioned(
          right: 0,
          top: 100,
          child: arrowButton(onTap: () => scrollRight(controller), isLeft: false),
        ),
      ],
    ),
  );
}

  /// 🔹 Section Title Widget
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
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

  /// 🔹 Manufacturer / Category Section
  Widget manufacturerSection(ScrollController controller) {
    return SizedBox(
      height: 140,
      child: Stack(
        children: [
          ListView.builder(
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
          Positioned(
          left: 0,
          top: 40,
          child: arrowButton(onTap: () => scrollLeft(controller), isLeft: true),
        ),
        Positioned(
          right: 0,
          top: 40,
          child: arrowButton(onTap: () => scrollRight(controller), isLeft: false),
        ),
        ],
      ),
    );
  }


  /// 🔹 Arrow Button
Widget arrowButton({required VoidCallback onTap, required bool isLeft}) {
  return IconButton(
    onPressed: onTap,
    icon: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
          ),
        ],
      ),
      child: Icon(
        isLeft ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
        size: 18,
      ),
    ),
  );
}

/// 🔹 Category Section
Widget categorySection(ScrollController controller) {
  return SizedBox(
    height: 140,
    child: Stack(
      children: [
        ListView.builder(
          controller: controller,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 5,
          itemBuilder: (context, index) {
            return const Menufacturers( // যদি আলাদা ক্যাটেগরি উইজেট থাকে, এখানে সেটি ব্যবহার করুন
              image: "assets/category3.png",
            );
          },
        ),
        Positioned(
          left: 0,
          top: 40,
          child: arrowButton(onTap: () => scrollLeft(controller), isLeft: true),
        ),
        Positioned(
          right: 0,
          top: 40,
          child: arrowButton(onTap: () => scrollRight(controller), isLeft: false),
        ),
      ],
    ),
  );
}

  /// 🔹 Banner Widget
  Widget bannerItem(String image) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}