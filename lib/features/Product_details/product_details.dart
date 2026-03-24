import 'package:flutter/material.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/TopNavigationBar.dart';
import '../../../widget/common/drowerRight.dart';

class ProductDetailsPage extends StatefulWidget {
  final int id;

  const ProductDetailsPage({super.key, required this.id});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {

  /// 🔥 দুইটা আলাদা controller
  final ScrollController _altScrollController = ScrollController();
  final ScrollController _recScrollController = ScrollController();

  /// 🔥 Alternative scroll
  void scrollLeftAlt() {
    _altScrollController.animateTo(
      _altScrollController.offset - 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void scrollRightAlt() {
    _altScrollController.animateTo(
      _altScrollController.offset + 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// 🔥 Recommended scroll
  void scrollLeftRec() {
    _recScrollController.animateTo(
      _recScrollController.offset - 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void scrollRightRec() {
    _recScrollController.animateTo(
      _recScrollController.offset + 200,
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

  /// 🔥 reusable card
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

          /// Image + badge
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

          /// Info
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
                    Text("৳144",
                        style: TextStyle(fontWeight: FontWeight.bold)),
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

  /// 🔥 section builder (reuse)
  Widget buildSection({
    required String title,
    required ScrollController controller,
    required VoidCallback onLeft,
    required VoidCallback onRight,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),

        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 130,
          child: Stack(
            children: [

              /// List
              ListView.builder(
                controller: controller,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) => productCard(),
              ),

              /// LEFT ARROW
              Positioned(
                left: 0,
                top: 40,
                child: InkWell(
                  onTap: onLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),

              /// RIGHT ARROW
              Positioned(
                right: 0,
                top: 40,
                child: InkWell(
                  onTap: onRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
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
    return Scaffold(
      appBar: const AppHeader(title: ""),
      endDrawer: const DrowerRight(),
      bottomNavigationBar: const CustomBottomNav(),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Image
            Image.asset(
              "assets/product.png",
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

                  Text(
                    "Product ID: ${widget.id}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  const Text("Tablet Bislol 5mg (56 Pcs)"),
                  const SizedBox(height: 5),
                  const Text("Bisoprolol",
                      style: TextStyle(color: Colors.blue)),

                  const SizedBox(height: 15),

                  /// Manufacturer + Delivery
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Manufacturer",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text("Beximco Pharmaceuticals Ltd"),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Delivery Date",
                              style: TextStyle(fontWeight: FontWeight.bold)),
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
                    onLeft: scrollLeftAlt,
                    onRight: scrollRightAlt,
                  ),

                  buildSection(
                    title: "Recommended for you",
                    controller: _recScrollController,
                    onLeft: scrollLeftRec,
                    onRight: scrollRightRec,
                  ),

                   const SizedBox(height: 15),

                  /// Manufacturer + Delivery
                  Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "৳144",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 6),

        Row(
          children: [
            const Text(
              "৳160",
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                fontSize: 13,
                color: Colors.grey,
              ),
            ),

            const SizedBox(width: 6),

            /// 🔥 NEW BEAUTIFUL BADGE
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.local_offer,
                    size: 12,
                    color: Colors.white,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "15% OFF",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),

    /// Button
    ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      ),
      child: const Text("Add To Bag"),
    ),
  ],
)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}