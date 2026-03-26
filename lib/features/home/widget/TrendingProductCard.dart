
import 'package:flutter/material.dart';
import '../../../widget/common/add_to_bag_button.dart';
import '../../../core/services/cart_service.dart';
import '../../../models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ashianahealth_mobile_app/main.dart';

// 👉 Details Page import করো
import '../../Product_details/product_details.dart';

class ProductCard extends StatelessWidget {
  final int id;
  final String title;
  final double price;
  final double oldPrice;
  final int discount;
  final String image;
  final bool outOfStock;
  

  const ProductCard({
    super.key,
    required this.id,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    this.outOfStock = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔥 CLICKABLE AREA (Image + Info)
          InkWell(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(id: id),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Image + Discount
                Stack(
                  children: [
                    Container(
                      height: 130,
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        cacheManager: MyCacheManager.instance,
                        memCacheWidth: 300,
                        memCacheHeight: 300,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),

                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "-$discount%",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// Info

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// 🔥 FIXED TEXT AREA
                      SizedBox(
                        height: 40, // 🔥 fixed height for 2 lines
                        child: Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            height: 1.2,
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          Text("৳ $price"),
                          const SizedBox(width: 6),
                          Text(
                            "৳ $oldPrice",
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// 🔥 BUTTON AREA (NO NAVIGATION)
         Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: AddToBagButton(
              productId: id,
              name: title,
              price: price,
              image: image,
              outOfStock: outOfStock,
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}