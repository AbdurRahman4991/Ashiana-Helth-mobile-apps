//
// import 'package:flutter/material.dart';
// import '../../../widget/common/add_to_bag_button.dart';
// import '../../../core/services/cart_service.dart';
// import '../../../core/services/ cart_counter.dart';
// import '../../../models/cart_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:ashianahealth_mobile_app/main.dart';
//
//
// class ProductCard extends StatelessWidget {
//   final int id;
//   final String title;
//   final double price;
//   final double oldPrice;
//   final int discount;
//   final String image;
//   final bool outOfStock;
//
//   const ProductCard({
//     super.key,
//     required this.id,
//     required this.title,
//     required this.price,
//     required this.oldPrice,
//     required this.discount,
//     required this.image,
//     this.outOfStock = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.shade200,
//             blurRadius: 5,
//           )
//         ],
//       ),
//       child: Row(
//         children: [
//
//           /// Image + Discount
//           Stack(
//             children: [
//               // Container(
//               //   width: 90,
//               //   height: 90,
//               //   padding: const EdgeInsets.all(8),
//               //   child: Image.network(image, fit: BoxFit.contain),
//               // ),
//               Container(
//                 width: 90,
//                 height: 90,
//                 padding: const EdgeInsets.all(8),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: CachedNetworkImage(
//                     imageUrl: image, // যেটা আগে network দিচ্ছিল
//                     cacheManager: MyCacheManager.instance,
//                     fit: BoxFit.contain,
//                     memCacheWidth: 300,
//                     memCacheHeight: 300,
//
//                     // loading placeholder
//                     placeholder: (context, url) => Container(
//                       color: Colors.grey.shade300,
//                     ),
//
//                     // error fallback
//                     errorWidget: (context, url, error) => Image.asset(
//                       "assets/product.png",
//                       fit: BoxFit.contain,
//                     ),
//
//                     fadeInDuration: const Duration(milliseconds: 300),
//                   ),
//                 ),
//               ),
//
//               Positioned(
//                 bottom: 0,
//                 child: Container(
//                   width: 90,
//                   color: Colors.red,
//                   padding: const EdgeInsets.symmetric(vertical: 3),
//                   child: Text(
//                     "$discount%",
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ),
//               )
//             ],
//           ),
//
//           const SizedBox(width: 10),
//
//           /// Product Info
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//
//                 Text(
//                   title,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//
//                 const SizedBox(height: 6),
//
//                 Row(
//                   children: [
//                     Text(
//                       "৳ $price",
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(width: 10),
//                     Text(
//                       "৳ $oldPrice",
//                       style: const TextStyle(
//                         decoration: TextDecoration.lineThrough,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 8),
//                 /// Button Widget
//                 AddToBagButton(
//                   outOfStock: outOfStock,
//                   onPressed: () async {
//                     SharedPreferences prefs = await SharedPreferences.getInstance();
//                     String? userIdString = prefs.getString('id'); // লগইন ইউজারের আইডি
//
//                     if (userIdString != null) {
//                       int userId = int.parse(userIdString); // String থেকে int-এ রূপান্তর
//
//                       CartItem item = CartItem(
//                         userId: userId, // এখন int টাইপ
//                         productId: id,
//                         name: title,
//                         price: price,
//                         image: image,
//                       );
//
//                       await CartService.addToCart(item);
//                       print("Product added to cart");
//                       cartCounter.value++;
//                     } else {
//                       print("User not logged in");
//                     }
//                   },
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../widget/common/add_to_bag_button.dart';
import '../../../core/services/cart_service.dart';
import '../../../core/services/ cart_counter.dart';
import '../../../models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ashianahealth_mobile_app/main.dart';

// 👉 details page import
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
    return InkWell(
      borderRadius: BorderRadius.circular(8),

      /// 🔥 CARD CLICK → DETAILS PAGE
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(id: id),
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 5,
            )
          ],
        ),
        child: Row(
          children: [

            /// 🖼️ Image + Discount
            Stack(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      cacheManager: MyCacheManager.instance,
                      fit: BoxFit.contain,
                      memCacheWidth: 300,
                      memCacheHeight: 300,

                      placeholder: (context, url) => Container(
                        color: Colors.grey.shade300,
                      ),

                      errorWidget: (context, url, error) =>
                          Image.asset("assets/product.png"),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 90,
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      "$discount%",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(width: 10),

            /// 📄 Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis, // ✅ overflow fix
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Text(
                        "৳ $price",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "৳ $oldPrice",
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// 🛒 BUTTON (NO NAVIGATION)
                  AddToBagButton(
                    outOfStock: outOfStock,
                    onPressed: () async {

                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                      String? userIdString = prefs.getString('id');

                      if (userIdString != null) {
                        int userId = int.parse(userIdString);

                        CartItem item = CartItem(
                          userId: userId,
                          productId: id,
                          name: title,
                          price: price,
                          image: image,
                        );

                        await CartService.addToCart(item);

                        /// 🔥 cart counter update
                        cartCounter.value++;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Added to Cart ✅"),
                            duration: Duration(seconds: 1),
                          ),
                        );

                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please login first"),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}