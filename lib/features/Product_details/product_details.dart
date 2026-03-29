import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../provider/product_details_provider.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/TopNavigationBar.dart';
import '../../../widget/common/drowerRight.dart';
import '../../../widget/common/add_to_bag_button.dart';
import '../../models/product_model.dart';

class ProductDetailsPage extends StatefulWidget {
  final int id;
  final bool outOfStock;

  const ProductDetailsPage({super.key, required this.id, this.outOfStock = false,});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {

  final ScrollController _altScrollController = ScrollController();
  final ScrollController _recScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<ProductDetailsProvider>(context, listen: false)
          .getProduct(widget.id);
    });
  }


  void scrollLeft(ScrollController controller) {
    controller.animateTo(
      controller.offset - 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void scrollRight(ScrollController controller) {
    controller.animateTo(
      controller.offset + 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _altScrollController.dispose();
    _recScrollController.dispose();
    super.dispose();
  }

  /// 🔥 Static Product Card
  Widget productCard() {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    image: AssetImage("assets/product.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  color: Colors.red,
                  child: const Text(
                    "10%",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Square Pharma",
                    style: TextStyle(fontSize: 11, color: Colors.grey)),
                SizedBox(height: 4),
                Text("Napa 500mg",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text("৳144", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 5),
                    Text(
                      "৳160",
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔥 Section Builder
  
  Widget buildSection({
  required String title,
  required ScrollController controller,
  required List<Product> products,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 10),
      Text(title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      const SizedBox(height: 10),
      SizedBox(
        height: 130,
        child: Stack(
          children: [
            ListView.builder(
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
  final item = products[index];

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductDetailsPage(id: item.id),
        ),
      );
    },
    child: Container(
      width: 200,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: item.image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  item.manufactureName ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),

                const SizedBox(height: 4),

                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "৳${item.discountedPrice}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        "৳${item.sellingPrice}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
            ),

            /// arrows
            Positioned(
              left: 0,
              top: 40,
              child: IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => scrollLeft(controller),
              ),
            ),
            Positioned(
              right: 0,
              top: 40,
              child: IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => scrollRight(controller),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductDetailsProvider>(context);
    final product = provider.product;

    return Scaffold(
      appBar: const AppHeader(title: ""),
      endDrawer: const DrowerRight(),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 0),

      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : product == null
              ? const Center(child: Text("No Data Found"))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// 🔥 Image
                      CachedNetworkImage(
                        imageUrl: product.image,
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),

                      const SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// Name
                            Text(product.name,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),

                            const SizedBox(height: 5),

                            /// Generic
                            Text(product.genericName,
                                style: const TextStyle(color: Colors.blue)),

                            const SizedBox(height: 15),

                            /// Manufacturer + Delivery
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [

                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Text("Manufacturer",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text(product.manufactureName),
                                  ],
                                ),

                                const Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                  children: [
                                    Text("Delivery Date",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 4),
                                    Text("21 Mar, 2:00 PM"),
                                  ],
                                ),
                              ],
                            ),

                            /// 🔥 Sections
                            buildSection(
                              title: "Alternative Brands",
                              controller: _altScrollController,
                              products: provider.alternativeBrands,
                            ),

                           buildSection(
                              title: "Recommended for you",
                              controller: _recScrollController,
                              products: provider.recommendedProducts,
                            ),

                            const SizedBox(height: 20),

                            // Positioned(
                            //   left: 0,
                            //   right: 0,
                            //   bottom: 10,
                            //   child: )

                            /// Price
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [

                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text("৳${product.discountedPrice}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Text("৳${product.sellingPrice}",
                                            style: const TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.grey)),
                                        const SizedBox(width: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            "${product.discountPercent}% OFF",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 11),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  width: 120,
                                  height: 40,
                                  child: AddToBagButton(
                                    productId: product.id,
                                    name: product.name,
                                    price: product.discountedPrice,
                                    image: product.image,
                                    outOfStock: widget.outOfStock,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}