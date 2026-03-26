
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:ashianahealth_mobile_app/main.dart';
// import '../../../models/cart_model.dart';
// import '../../../core/services/cart_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // 👉 details page import
// import '../../Product_details/product_details.dart';

// class Menufacturers extends StatelessWidget {
//   final int id;
//   final String image;
//   final String name;
//   final String manufacturerName;
//   final double sellingPrice;
//   final double discountedPrice;
//   final double discountPercent;
//   final bool outOfStock;

//   const Menufacturers({
//     super.key,
//     required this.id,
//     required this.image,
//     required this.name,
//     required this.manufacturerName,
//     required this.sellingPrice,
//     required this.discountedPrice,
//     required this.discountPercent,
//     this.outOfStock = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(8),

//       /// 🔥 CARD CLICK → DETAILS PAGE
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProductDetailsPage(id: id),
//           ),
//         );
//       },

//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.shade200,
//               blurRadius: 5,
//             )
//           ],
//         ),
//         child: Row(
//           children: [

//             /// 🖼️ Image + Discount
//             Stack(
//               children: [
//                 Container(
//                   width: 90,
//                   height: 90,
//                   padding: const EdgeInsets.all(8),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: CachedNetworkImage(
//                       imageUrl: image.isNotEmpty
//                           ? "https://demoapp.ashianahealth.com/storage/products/$image"
//                           : "https://via.placeholder.com/90",

//                       cacheManager: MyCacheManager.instance,
//                       fit: BoxFit.cover,
//                       memCacheWidth: 300,
//                       memCacheHeight: 300,

//                       placeholder: (context, url) =>
//                           Container(color: Colors.grey.shade300),

//                       errorWidget: (context, url, error) =>
//                           Image.asset("assets/product.png"),
//                     ),
//                   ),
//                 ),

//                 if (discountPercent > 0)
//                   Positioned(
//                     bottom: 0,
//                     child: Container(
//                       width: 90,
//                       color: Colors.red,
//                       padding:
//                           const EdgeInsets.symmetric(vertical: 3),
//                       child: Text(
//                         "${discountPercent.toStringAsFixed(0)}%",
//                         textAlign: TextAlign.center,
//                         style:
//                             const TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   )
//               ],
//             ),

//             const SizedBox(width: 10),

//             /// 📄 Info
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [

//                   Text(
//                     manufacturerName,
//                     style: const TextStyle(
//                         fontSize: 12, color: Colors.grey),
//                   ),

//                   const SizedBox(height: 4),

//                   Text(
//                     name,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold),
//                   ),

//                   const SizedBox(height: 6),

//                   Row(
//                     children: [
//                       Text(
//                         "৳ ${discountedPrice.toStringAsFixed(2)}",
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold),
//                       ),

//                       const SizedBox(width: 10),

//                       if (sellingPrice != discountedPrice)
//                         Text(
//                           "৳ ${sellingPrice.toStringAsFixed(2)}",
//                           style: const TextStyle(
//                             decoration:
//                                 TextDecoration.lineThrough,
//                             color: Colors.grey,
//                           ),
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             /// 🛒 BUTTON (NO NAVIGATION)
//             ElevatedButton(
//               onPressed: () async {
//                 SharedPreferences prefs =
//                     await SharedPreferences.getInstance();
//                 String? userIdString = prefs.getString('id');

//                 if (userIdString != null) {
//                   int userId = int.parse(userIdString);

//                   CartItem cartItem = CartItem(
//                     userId: userId,
//                     productId: id,
//                     name: name,
//                     price: discountedPrice,
//                     image:
//                         "https://demoapp.ashianahealth.com/storage/products/$image",
//                   );

//                   await CartService.addToCart(cartItem);

//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                         content: Text("Added to Cart ✅")),
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                         content: Text("Please login first")),
//                   );
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 12, vertical: 8),
//                 textStyle: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//               child: const Text("Add To Bag"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ashianahealth_mobile_app/main.dart';
import '../../../widget/common/add_to_bag_button.dart';

// 👉 details page import
import '../../Product_details/product_details.dart';

class Menufacturers extends StatelessWidget {
  final int id;
  final String image;
  final String name;
  final String manufacturerName;
  final double sellingPrice;
  final double discountedPrice;
  final double discountPercent;
  final bool outOfStock;

  const Menufacturers({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.manufacturerName,
    required this.sellingPrice,
    required this.discountedPrice,
    required this.discountPercent,
    this.outOfStock = false,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = image.isNotEmpty
        ? "https://demoapp.ashianahealth.com/storage/products/$image"
        : "https://via.placeholder.com/90";

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
          )
        ],
      ),
      child: Row(
        children: [

          /// 🔥 LEFT SIDE (CLICKABLE AREA)
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ProductDetailsPage(id: id),
                  ),
                );
              },
              child: Row(
                children: [

                  /// 🖼️ Image + Discount
                  Stack(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        padding: const EdgeInsets.all(6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            cacheManager: MyCacheManager.instance,
                            fit: BoxFit.cover,
                            memCacheWidth: 300,
                            memCacheHeight: 300,
                            placeholder: (_, __) =>
                                Container(color: Colors.grey.shade300),
                            errorWidget: (_, __, ___) =>
                                Image.asset("assets/product.png"),
                          ),
                        ),
                      ),

                      if (discountPercent > 0)
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: 90,
                            padding:
                                const EdgeInsets.symmetric(vertical: 3),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                              ),
                            ),
                            child: Text(
                              "-${discountPercent.toStringAsFixed(0)}%",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(width: 10),

                  /// 📄 Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Text(
                          manufacturerName,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Row(
                          children: [
                            Text(
                              "৳ ${discountedPrice.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(width: 6),

                            if (sellingPrice != discountedPrice)
                              Text(
                                "৳ ${sellingPrice.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  decoration:
                                      TextDecoration.lineThrough,
                                  color: Colors.grey,
                                  fontSize: 12,
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
          ),

          const SizedBox(width: 8),

          /// 🛒 RIGHT SIDE BUTTON
          SizedBox(
            width: 100,
            child: AddToBagButton(
              productId: id,
              name: name,
              price: discountedPrice,
              image: imageUrl,
              outOfStock: outOfStock,
            ),
          ),
        ],
      ),
    );
  }
}