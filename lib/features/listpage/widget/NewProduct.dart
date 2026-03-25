//
// import 'package:flutter/material.dart';
// import '../../../models/product_model.dart';
// import '../../../models/cart_model.dart';
// import '../../../core/services/cart_service.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:ashianahealth_mobile_app/main.dart';
//
// class NewProduct extends StatelessWidget {
//   final Product product; // dynamic data
//
//   const NewProduct({super.key, required this.product});
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
//           /// Product Image + Discount
//           Stack(
//             children: [
//               // Container(
//               //   width: 90,
//               //   height: 90,
//               //   padding: const EdgeInsets.all(8),
//               //   child: Image.network(
//               //     product.image.isNotEmpty
//               //         ? "https://demoapp.ashianahealth.com/storage/products/${product.image}"
//               //         : "https://via.placeholder.com/90",
//               //     fit: BoxFit.cover,
//               //   ),
//               // ),
//               Container(
//                 width: 90,
//                 height: 90,
//                 padding: const EdgeInsets.all(8),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: CachedNetworkImage(
//                     imageUrl: product.image.isNotEmpty
//                         ? "https://demoapp.ashianahealth.com/storage/products/${product.image}"
//                         : "https://via.placeholder.com/90",
//
//                     cacheManager: MyCacheManager.instance,
//                     fit: BoxFit.cover,
//
//                     memCacheWidth: 300,
//                     memCacheHeight: 300,
//
//                     // ✅ loading
//                     placeholder: (context, url) => Container(
//                       color: Colors.grey.shade300,
//                     ),
//
//                     // ✅ error fallback
//                     errorWidget: (context, url, error) => Image.asset(
//                       "assets/product.png",
//                       fit: BoxFit.cover,
//                     ),
//
//                     fadeInDuration: const Duration(milliseconds: 300),
//                   ),
//                 ),
//               ),
//
//               if (product.discountPercent != null && product.discountPercent! > 0)
//                 Positioned(
//                   bottom: 0,
//                   child: Container(
//                     width: 90,
//                     color: Colors.red,
//                     padding: const EdgeInsets.symmetric(vertical: 3),
//                     child: Text(
//                       "${product.discountPercent!.toStringAsFixed(2)}%",
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 )
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
//                   product.manufacturing?.name ?? "",
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey,
//                   ),
//                 ),
//
//                 const SizedBox(height: 4),
//
//                 Text(
//                   product.name,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//
//                 const SizedBox(height: 6),
//
//                 Row(
//                   children: [
//                     Text(
//                       "৳ ${product.discountedPrice.toStringAsFixed(2)}",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     if (product.sellingPrice != product.discountedPrice)
//                       Text(
//                         "৳ ${product.sellingPrice.toStringAsFixed(2)}",
//                         style: const TextStyle(
//                           decoration: TextDecoration.lineThrough,
//                           color: Colors.grey,
//                         ),
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//
//           /// Button
//           ElevatedButton(
//             onPressed: () async {
//
//               CartItem cartItem = CartItem(
//                 userId: 15,
//                 productId: product.id,
//                 name: product.name,
//                 price: product.discountedPrice,
//                 image: "https://demoapp.ashianahealth.com/storage/products/${product.image}",
//               );
//
//               await CartService.addToCart(cartItem);
//
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text("Added to Cart")),
//               );
//
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.green,
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               textStyle: const TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               elevation: 2,
//             ),
//             child: const Text("Add To Bag"),
//           ),
//
//
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../../models/product_model.dart';
import '../../../models/cart_model.dart';
import '../../../core/services/cart_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ashianahealth_mobile_app/main.dart';

// 👉 details page import
import '../../Product_details/product_details.dart';

class NewProduct extends StatelessWidget {
  final Product product;

  const NewProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),

      /// 🔥 CARD CLICK → DETAILS PAGE
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDetailsPage(id: product.id),
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
                      imageUrl: product.image.isNotEmpty
                          ? "https://demoapp.ashianahealth.com/storage/products/${product.image}"
                          : "https://via.placeholder.com/90",

                      cacheManager: MyCacheManager.instance,
                      fit: BoxFit.cover,
                      memCacheWidth: 300,
                      memCacheHeight: 300,

                      placeholder: (context, url) =>
                          Container(color: Colors.grey.shade300),

                      errorWidget: (context, url, error) =>
                          Image.asset("assets/product.png"),
                    ),
                  ),
                ),

                if (product.discountPercent > 0)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 90,
                      color: Colors.red,
                      padding:
                      const EdgeInsets.symmetric(vertical: 3),
                      child: Text(
                        "${product.discountPercent.toStringAsFixed(0)}%",
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
                    product.manufacturing?.name ?? "",
                    style: const TextStyle(
                        fontSize: 12, color: Colors.grey),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis, // ✅ overflow fix
                    style: const TextStyle(
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Text(
                        "৳ ${product.discountedPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),

                      if (product.sellingPrice !=
                          product.discountedPrice)
                        Text(
                          "৳ ${product.sellingPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                            decoration:
                            TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            /// 🛒 BUTTON (NO NAVIGATION)
            ElevatedButton(
              onPressed: () async {

                CartItem cartItem = CartItem(
                  userId: 15,
                  productId: product.id,
                  name: product.name,
                  price: product.discountedPrice,
                  image:
                  "https://demoapp.ashianahealth.com/storage/products/${product.image}",
                );

                await CartService.addToCart(cartItem);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Added to Cart ✅")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text("Add To Bag"),
            ),
          ],
        ),
      ),
    );
  }
}