import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../widget/TrendingProductCard.dart';
import '../widget/MenuFacturers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _trendingController = ScrollController();
  final ScrollController _menufacturersController = ScrollController();
  final ScrollController _newProductController = ScrollController();

  void scrollTrendingLeft() {
    _trendingController.animateTo(
      _trendingController.offset - 220,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void scrollTrendingRight() {
    _trendingController.animateTo(
      _trendingController.offset + 220,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
  void scrollMenufacturersLeft() {
    _menufacturersController.animateTo(
      _menufacturersController.offset - 220,
      duration: const Duration(microseconds: 400),
      curve: Curves.easeInOut,
    );
  }

   void scrollMenufacturersRight() {
     _menufacturersController.animateTo(
       _menufacturersController.offset - 220,
       duration: const Duration(microseconds: 400),
       curve: Curves.easeInOut,
     );
  }


  void scrollNewLeft() {
    _newProductController.animateTo(
      _newProductController.offset - 220,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void scrollNewRight() {
    _newProductController.animateTo(
      _newProductController.offset + 220,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
  @override
  void dispose() {
    _trendingController.dispose();
    _newProductController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNav(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔍 Search Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 50,
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
                      )
                    ],
                  ),
                ),
              ),

              /// 🎯 Banner Carousel
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

              /// 🔥 Trending Section Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Trending",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "See all",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// 🛍 Trending Product List With Arrows
              SizedBox(
                height: 270,
                child: Stack(
                  children: [

                    /// Product List
                    ListView.builder(
                      controller: _trendingController,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const ProductCard(
                          title: "Furoclav 250mg Tablet",
                          price: 375,
                          oldPrice: 500,
                          discount: 25,
                          image: "assets/product.png",
                          outOfStock: true,
                        );
                      },
                    ),

                    /// Left Arrow
                    Positioned(
                      left: 0,
                      top: 100,
                      child: IconButton(
                        onPressed: scrollTrendingLeft,
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
                          child: const Icon(Icons.arrow_back_ios, size: 18),
                        ),
                      ),
                    ),

                    /// Right Arrow
                    Positioned(
                      right: 0,
                      top: 100,
                      child: IconButton(
                        onPressed: scrollTrendingRight,
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
                          child: const Icon(Icons.arrow_forward_ios, size: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ===================Menufactuerers=================== //

              /// 🔥 Menufacturers Section Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Menufatcurers",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Discover all",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// 🛍 Menufacturers List With Arrows
              SizedBox(
                height: 270,
                child: Stack(
                  children: [

                    /// menufacturers List
                    ListView.builder(
                      controller: _menufacturersController,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const Menufacturers(
                          image: "assets/product.png",
                        );
                      },
                    ),

                    /// Left Arrow
                    Positioned(
                      left: 0,
                      top: 100,
                      child: IconButton(
                        onPressed: scrollTrendingLeft,
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
                          child: const Icon(Icons.arrow_back_ios, size: 18),
                        ),
                      ),
                    ),

                    /// Right Arrow
                    Positioned(
                      right: 0,
                      top: 100,
                      child: IconButton(
                        onPressed: scrollTrendingRight,
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
                          child: const Icon(Icons.arrow_forward_ios, size: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),



              // ====================New product====================== //

              const SizedBox(height: 20),

              // 🔥 New product Section Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.fiber_new,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "New Products",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "See all",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// 🛍 New Product List With Arrows
              SizedBox(
                height: 270,
                child: Stack(
                  children: [

                    /// Product List
                    ListView.builder(
                      controller: _newProductController,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const ProductCard(
                          title: "Furoclav 250mg Tablet",
                          price: 375,
                          oldPrice: 500,
                          discount: 25,
                          image: "assets/product.png",
                          outOfStock: true,
                        );
                      },
                    ),

                    /// Left Arrow
                    Positioned(
                      left: 0,
                      top: 100,
                      child: IconButton(
                        onPressed: scrollNewLeft,
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
                          child: const Icon(Icons.arrow_back_ios, size: 18),
                        ),
                      ),
                    ),

                    /// Right Arrow
                    Positioned(
                      right: 0,
                      top: 100,
                      child: IconButton(
                        onPressed: scrollNewRight,
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
                          child: const Icon(Icons.arrow_forward_ios, size: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ===================Categories=================== //

              /// 🔥 Categori Section Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Discover all",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// 🛍 Categori List With Arrows
              SizedBox(
                height: 270,
                child: Stack(
                  children: [

                    /// Categori List
                    ListView.builder(
                      controller: _menufacturersController,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const Menufacturers(
                          image: "assets/product.png",
                        );
                      },
                    ),

                    /// Left Arrow
                    Positioned(
                      left: 0,
                      top: 100,
                      child: IconButton(
                        onPressed: scrollTrendingLeft,
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
                          child: const Icon(Icons.arrow_back_ios, size: 18),
                        ),
                      ),
                    ),

                    /// Right Arrow
                    Positioned(
                      right: 0,
                      top: 100,
                      child: IconButton(
                        onPressed: scrollTrendingRight,
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
                          child: const Icon(Icons.arrow_forward_ios, size: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Banner Item Widget
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