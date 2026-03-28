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
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Colors.green),
                            const SizedBox(width: 10),
                            Expanded(
                              child:

                            TextField(
                              decoration: const InputDecoration(
                                hintText: "Search by brand, generic...",
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                if (value.length >= 3) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchPage(searchText: value),
                                    ),
                                  );
                                }
                              },
                            ),
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
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 600),
                        enableInfiniteScroll: sliders.length > 1,
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
                       onPressed: () => openFilter(context),
                       // child: Text("Open Filter"),
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
                      onPressed: () => openFilter(context),
                    ),
                    const SizedBox(height: 10),
                    categorySection(_categoriesController),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
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
  ///
  Widget trendingProductSection(ScrollController controller) {
    final provider = Provider.of<HomeProvider>(context);
    final products = provider.homeData?.data?.trendingProducts ?? [];

    return SizedBox(
      height: 270,
      child: Stack(
        children: [
          ListView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 50), // arrow এর জন্য space
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(

                id:product.id!,
                title: product.name ?? "",
                price: double.parse(product.discountedPrice ?? "0"),
                oldPrice: double.parse(product.sellingPrice ?? "0"),
                discount: double.parse(product.discountPercent ?? "0").toInt(),
                image: product.image ?? "",
                outOfStock: (product.stock ?? 0) <= 0,
              );
            },
          ),

          /// ⬅ Left Arrow
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.green,
                onPressed: () {
                  controller.animateTo(
                    controller.offset - 220, // scroll distance
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
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                color: Colors.green,
                onPressed: () {
                  controller.animateTo(
                    controller.offset + 220,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }


  /// 🔹 Manufacturer Section

  Widget manufacturerSection(ScrollController controller) {
    final provider = Provider.of<HomeProvider>(context);
    final manufacturers = provider.homeData?.data?.manufacturers ?? [];

    return SizedBox(
      height: 140,
      child: Stack(
        children: [
          ListView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 50), // arrow জন্য space
            itemCount: manufacturers.length,
            itemBuilder: (context, index) {
              final item = manufacturers[index];
              // print(item.id);
              return GestureDetector(
                onTap:(){ Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenufacturersListPage(
                      manufacturerId: item.id ?? 0,
                    ),
                   ),
                );
                },


              child: Menufacturers(
                id: item.id ?? 0,
                image: item.logo ?? "",

              ),
              );

            },
          ),

          /// ⬅ Left Arrow
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.green,
                onPressed: () {
                  controller.animateTo(
                    controller.offset - 220, // scroll distance
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
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                color: Colors.green,
                onPressed: () {
                  controller.animateTo(
                    controller.offset + 220,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }


   /// 🔹 New Product Section

  Widget newProductSection(ScrollController controller) {
    final provider = Provider.of<HomeProvider>(context);
    final products = provider.homeData?.data?.newProducts ?? [];

    return SizedBox(
      height: 270,
      child: Stack(
        children: [
          ListView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 50), // arrow জন্য space
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return NewProductCard(
                id:product.id!,
                title: product.name ?? "",
                price: double.parse(product.discountedPrice ?? "0"),
                oldPrice: double.parse(product.sellingPrice ?? "0"),
                discount: double.parse(product.discountPercent ?? "0").toInt(),
                image: product.image ?? "",
                outOfStock: (product.stock ?? 0) <= 0,
              );
            },
          ),

          /// ⬅ Left Arrow
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.green,
                onPressed: () {
                  controller.animateTo(
                    controller.offset - 220,
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
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                color: Colors.green,
                onPressed: () {
                  controller.animateTo(
                    controller.offset + 220,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Category Section
  Widget categorySection(ScrollController controller) {
    final provider = Provider.of<HomeProvider>(context);
    final categories = provider.homeData?.data?.categories ?? [];

    return SizedBox(
      height: 140,
      child: Stack(
        children: [
          ListView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 50), // arrow জন্য space
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final item = categories[index];

              //print(item.id);
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context)=> CategoriListPage(
                          categoriesId: item.id ?? 0,
                        ),
                    ),
                    );
                },
                child: Categories(
                id: item.id ?? 0,
                image: item.image ?? "",
                // image: item.image != null
                //     ? ApiConfig.productImage(item.image!)
                //     : "",
              ),
              );
            },
          ),

          /// ⬅ Left Arrow
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.green,
                onPressed: () {
                  controller.animateTo(
                    controller.offset - 180, // scroll distance
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
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                color: Colors.green,
                onPressed: () {
                  controller.animateTo(
                    controller.offset + 180, // scroll distance
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
        ],
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