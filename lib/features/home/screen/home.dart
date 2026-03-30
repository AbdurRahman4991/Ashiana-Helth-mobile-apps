import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../../../provider/home_provider.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/TopNavigationBar.dart';
import '../../../widget/common/drowerRight.dart';
import '../widget/TrendingProductCard.dart';
import '../widget/NewProduct.dart';
import '../widget/MenuFacturers.dart';
import '../widget/Categories.dart';
import '../../listpage/screens/TrendingProductList.dart';
import '../../listpage/screens/MenufacturersList.dart';
import '../../listpage/screens/NewProductListh.dart';
import '../../listpage/screens/CategoryList.dart';
import '../../../features/home/screen/search.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ashianahealth_mobile_app/main.dart';
import '../../../widget/common/FilterByCompanyCategory.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   //int? userId;

  final ScrollController _trendingController = ScrollController();
  final ScrollController _menufacturersController = ScrollController();
  final ScrollController _newProductController = ScrollController();
  final ScrollController _categoriesController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Load data + preload images
    Future.microtask(() async {
      final provider = Provider.of<HomeProvider>(context, listen: false);
     // await provider.getHomeData(); // API call
      if (provider.homeData == null) {
        await provider.getHomeData();
      }
      // ✅ Preload Slider images
      for (var slider in provider.homeData?.data?.sliders ?? []) {
        if (slider.image != null && slider.image!.isNotEmpty) {
          precacheImage(
            CachedNetworkImageProvider(slider.image!),
            context,
          );
        }
      }

      // ✅ Preload Trending Products images
      for (var product in provider.homeData?.data?.trendingProducts ?? []) {
        if (product.image != null && product.image!.isNotEmpty) {
          precacheImage(
            CachedNetworkImageProvider(product.image!),
            context,
          );
        }
      }

      // ✅ Preload New Products images
      for (var product in provider.homeData?.data?.newProducts ?? []) {
        if (product.image != null && product.image!.isNotEmpty) {
          precacheImage(
            CachedNetworkImageProvider(product.image!),
            context,
          );
        }
      }

      // ✅ Preload Categories images
      for (var category in provider.homeData?.data?.categories ?? []) {
        if (category.image != null && category.image!.isNotEmpty) {
          precacheImage(
            CachedNetworkImageProvider(category.image!),
            context,
          );
        }
      }
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

  void openFilter(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return const FilterSheet();
    },
  );
}

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<HomeProvider>(context);
    final sliders = provider.homeData?.data?.sliders ?? [];

    return
      WillPopScope(
          onWillPop: () async {
            // Alert dialog for exit
            final exit = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Exit App'),
                content: const Text('Do you really want to exit the app?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Yes'),
                  ),
                ],
              ),
            );
            return exit ?? false; // if dialog dismissed, don't exit
          },
      child: Scaffold(
      appBar: const AppHeader(title: ""),
      endDrawer: const DrowerRight(),
      bottomNavigationBar: CustomBottomNav(currentIndex: 0),

      body: SafeArea(
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
        :SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔍 Search Bar
              Padding(
                padding: const EdgeInsets.all(16), // ✅ consistent outer padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// 🔹 Search Box
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.green),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: "Search by brand, generic...",
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                if (value.length >= 3) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SearchPage(searchText: value),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16), // spacing between search and banner

                    /// 🔹 Banner Slider
                    // CarouselSlider(
                    //   options: CarouselOptions(
                    //     height: 160,
                    //     autoPlay: sliders.length > 1,
                    //     enlargeCenterPage: true,
                    //     viewportFraction: 0.85,
                    //     autoPlayInterval: const Duration(seconds: 3),
                    //     autoPlayAnimationDuration: const Duration(milliseconds: 600),
                    //     enableInfiniteScroll: sliders.length > 1,
                    //     pauseAutoPlayOnTouch: true,
                    //     scrollPhysics: const BouncingScrollPhysics(),
                    //   ),
                    //   items: sliders.map((slider) {
                    //     return ClipRRect(
                    //       borderRadius: BorderRadius.circular(12),
                    //       child: bannerItem(slider.image ?? ""),
                    //     );
                    //   }).toList(),
                    // ),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 160, // চাইলে MediaQuery দিয়ে dynamic height দিতে পারো
                        autoPlay: sliders.length > 1,
                        enlargeCenterPage: false, // enlarge করার দরকার নেই
                        viewportFraction: 1.0, // পুরো স্ক্রিন
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(milliseconds: 600),
                        enableInfiniteScroll: sliders.length > 1,
                        pauseAutoPlayOnTouch: true,
                        scrollPhysics: const BouncingScrollPhysics(),
                      ),
                      items: sliders.map((slider) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(0), // চাইলে 0 বা কিছু radius দিতে পারো
                          child: bannerItem(slider.image ?? ""),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// 🔥 Trending
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: sectionTitle(
                  Icons.local_fire_department,
                  "Trending",
                  "See all",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TrendingProductListPage(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              trendingProductSection(),

              const SizedBox(height: 20),

              /// 🏭 Manufacturers
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: sectionTitle(
                  Icons.factory,
                  "Manufacturers",
                  "Discover all",
                  onPressed: () => openFilter(context),
                ),
              ),
              const SizedBox(height: 10),
             // manufacturerSection(_menufacturersController),
              manufacturerSection(),

              const SizedBox(height: 20),

              /// 🆕 New Products
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: sectionTitle(
                  Icons.fiber_new,
                  "New Products",
                  "See all",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NewProductListPage(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              //newProductSection(_newProductController),
              newProductSection(),

              const SizedBox(height: 20),

              /// 📦 Categories
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: sectionTitle(
                  Icons.category,
                  "Categories",
                  "Discover all",
                  onPressed: () => openFilter(context),
                ),
              ),
              const SizedBox(height: 10),
              categorySection(),

              const SizedBox(height: 30),
            ],
          ),
        )
      )
      ),
    );
  }

  /// 🔹 Banner Widget

  Widget bannerItem(String imageUrl) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        cacheManager: MyCacheManager.instance,

        // 🔥 VERY IMPORTANT
        memCacheWidth: 600, // কমাও (800 → 600)

        fadeInDuration: const Duration(milliseconds: 200),

        placeholder: (context, url) => Container(
          color: Colors.grey.shade200,
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),

        errorWidget: (context, url, error) =>
        const Icon(Icons.image_not_supported),

        fit: BoxFit.cover,
      ),
    );
  }

  /// 🔹 Trending Section (আগের মতো)

  PageController _pageController = PageController();

  Widget trendingProductSection() {
    final provider = Provider.of<HomeProvider>(context);
    final products = provider.homeData?.data?.trendingProducts ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 270,
        child: Stack(
          children: [

            /// 🔥 PageView
            PageView.builder(
              controller: _pageController,
              itemCount: (products.length / 2).ceil(),
              itemBuilder: (context, pageIndex) {
                int firstIndex = pageIndex * 2;
                int secondIndex = firstIndex + 1;

                return Row(
                  children: [
                    Expanded(
                      child: ProductCard(
                        id: products[firstIndex].id!,
                        title: products[firstIndex].name ?? "",
                        price: double.parse(products[firstIndex].discountedPrice ?? "0"),
                        oldPrice: double.parse(products[firstIndex].sellingPrice ?? "0"),
                        discount: double.parse(products[firstIndex].discountPercent ?? "0").toInt(),
                        image: products[firstIndex].image ?? "",
                        outOfStock: (products[firstIndex].stock ?? 0) <= 0,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: secondIndex < products.length
                          ? ProductCard(
                        id: products[secondIndex].id!,
                        title: products[secondIndex].name ?? "",
                        price: double.parse(products[secondIndex].discountedPrice ?? "0"),
                        oldPrice: double.parse(products[secondIndex].sellingPrice ?? "0"),
                        discount: double.parse(products[secondIndex].discountPercent ?? "0").toInt(),
                        image: products[secondIndex].image ?? "",
                        outOfStock: (products[secondIndex].stock ?? 0) <= 0,
                      )
                          : const SizedBox(),
                    ),
                  ],
                );
              },
            ),

            /// ⬅ Left Arrow
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: _arrowButton(
                  icon: Icons.arrow_back_ios,
                  onTap: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),

            /// ➡ Right Arrow
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: _arrowButton(
                  icon: Icons.arrow_forward_ios,
                  onTap: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _arrowButton({required IconData icon, required VoidCallback onTap}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6,
        )
      ],
    ),
    child: IconButton(
      icon: Icon(icon, size: 18),
      onPressed: onTap,
    ),
  );
}


  /// 🔹 Manufacturer Section


  /// 🔹 Manufacturer Section (PageView + Arrows)
  PageController _manufacturerPageController = PageController();

  Widget manufacturerSection() {
    final provider = Provider.of<HomeProvider>(context);
    final manufacturers = provider.homeData?.data?.manufacturers ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 140,
        child: Stack(
          children: [

            /// 🏭 PageView for Manufacturers
            PageView.builder(
              controller: _manufacturerPageController,
              itemCount: (manufacturers.length / 2).ceil(), // দুইটি করে দেখানো হবে
              itemBuilder: (context, pageIndex) {
                int firstIndex = pageIndex * 2;
                int secondIndex = firstIndex + 1;

                return Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenufacturersListPage(
                                manufacturerId: manufacturers[firstIndex].id ?? 0,
                              ),
                            ),
                          );
                        },
                        child: Menufacturers(
                          id: manufacturers[firstIndex].id ?? 0,
                          image: manufacturers[firstIndex].logo ?? "",
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: secondIndex < manufacturers.length
                          ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenufacturersListPage(
                                manufacturerId: manufacturers[secondIndex].id ?? 0,
                              ),
                            ),
                          );
                        },
                        child: Menufacturers(
                          id: manufacturers[secondIndex].id ?? 0,
                          image: manufacturers[secondIndex].logo ?? "",
                        ),
                      )
                          : const SizedBox(),
                    ),
                  ],
                );
              },
            ),

            /// ⬅ Left Arrow
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: _arrowButton(
                  icon: Icons.arrow_back_ios,
                  onTap: () {
                    _manufacturerPageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),

            /// ➡ Right Arrow
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: _arrowButton(
                  icon: Icons.arrow_forward_ios,
                  onTap: () {
                    _manufacturerPageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }




   /// 🔹 New Product Section

  /// 🔹 New Product Section (PageView + Arrows)
  PageController _newProductPageController = PageController();

  Widget newProductSection() {
    final provider = Provider.of<HomeProvider>(context);
    final products = provider.homeData?.data?.newProducts ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 270,
        child: Stack(
          children: [

            /// 🆕 PageView for New Products
            PageView.builder(
              controller: _newProductPageController,
              itemCount: (products.length / 2).ceil(), // দুইটি করে দেখানো হবে
              itemBuilder: (context, pageIndex) {
                int firstIndex = pageIndex * 2;
                int secondIndex = firstIndex + 1;

                return Row(
                  children: [
                    Expanded(
                      child: NewProductCard(
                        id: products[firstIndex].id!,
                        title: products[firstIndex].name ?? "",
                        price: double.parse(products[firstIndex].discountedPrice ?? "0"),
                        oldPrice: double.parse(products[firstIndex].sellingPrice ?? "0"),
                        discount: double.parse(products[firstIndex].discountPercent ?? "0").toInt(),
                        image: products[firstIndex].image ?? "",
                        outOfStock: (products[firstIndex].stock ?? 0) <= 0,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: secondIndex < products.length
                          ? NewProductCard(
                        id: products[secondIndex].id!,
                        title: products[secondIndex].name ?? "",
                        price: double.parse(products[secondIndex].discountedPrice ?? "0"),
                        oldPrice: double.parse(products[secondIndex].sellingPrice ?? "0"),
                        discount: double.parse(products[secondIndex].discountPercent ?? "0").toInt(),
                        image: products[secondIndex].image ?? "",
                        outOfStock: (products[secondIndex].stock ?? 0) <= 0,
                      )
                          : const SizedBox(),
                    ),
                  ],
                );
              },
            ),

            /// ⬅ Left Arrow
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: _arrowButton(
                  icon: Icons.arrow_back_ios,
                  onTap: () {
                    _newProductPageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),

            /// ➡ Right Arrow
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: _arrowButton(
                  icon: Icons.arrow_forward_ios,
                  onTap: () {
                    _newProductPageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Category Section
  /// 🔹 Category Section (PageView + Arrows)
  PageController _categoryPageController = PageController();

  Widget categorySection() {
    final provider = Provider.of<HomeProvider>(context);
    final categories = provider.homeData?.data?.categories ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 140,
        child: Stack(
          children: [

            /// 📂 PageView for Categories
            PageView.builder(
              controller: _categoryPageController,
              itemCount: (categories.length / 2).ceil(), // দুইটি করে দেখানো হবে
              itemBuilder: (context, pageIndex) {
                int firstIndex = pageIndex * 2;
                int secondIndex = firstIndex + 1;

                return Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoriListPage(
                                categoriesId: categories[firstIndex].id ?? 0,
                              ),
                            ),
                          );
                        },
                        child: Categories(
                          id: categories[firstIndex].id ?? 0,
                          image: categories[firstIndex].image ?? "",
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: secondIndex < categories.length
                          ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoriListPage(
                                categoriesId: categories[secondIndex].id ?? 0,
                              ),
                            ),
                          );
                        },
                        child: Categories(
                          id: categories[secondIndex].id ?? 0,
                          image: categories[secondIndex].image ?? "",
                        ),
                      )
                          : const SizedBox(),
                    ),
                  ],
                );
              },
            ),

            /// ⬅ Left Arrow
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: _arrowButton(
                  icon: Icons.arrow_back_ios,
                  onTap: () {
                    _categoryPageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),

            /// ➡ Right Arrow
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: _arrowButton(
                  icon: Icons.arrow_forward_ios,
                  onTap: () {
                    _categoryPageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
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