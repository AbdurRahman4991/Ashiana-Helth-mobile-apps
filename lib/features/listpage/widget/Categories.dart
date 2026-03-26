
// import 'package:flutter/material.dart';
// import '../../../models/product_model.dart';
// import '../../../models/cart_model.dart';
// import '../../../core/services/cart_service.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:ashianahealth_mobile_app/main.dart';

// // 👉 details page import করো
// import '../../Product_details/product_details.dart';

// class Categories extends StatelessWidget {
//   final Product product;

//   const Categories({
//     super.key,
//     required this.product,
//   });

//   @override
//   Widget build(BuildContext context) {

//     return InkWell(
//       borderRadius: BorderRadius.circular(8),

//       /// 🔥 CLICK → DETAILS PAGE
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProductDetailsPage(id: product.id),
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

//             /// 🖼️ Product Image
//             Stack(
//               children: [
//                 Container(
//                   width: 90,
//                   height: 90,
//                   padding: const EdgeInsets.all(8),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: CachedNetworkImage(
//                       imageUrl:
//                       "https://demoapp.ashianahealth.com/storage/products/${product.image}",

//                       cacheManager: MyCacheManager.instance,
//                       fit: BoxFit.cover,
//                       memCacheWidth: 300,
//                       memCacheHeight: 300,

//                       placeholder: (context, url) => Container(
//                         color: Colors.grey.shade300,
//                       ),

//                       errorWidget: (context, url, error) => Image.asset(
//                         "assets/product.png",
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),

//                 /// 🔥 Discount Badge
//                 Positioned(
//                   bottom: 0,
//                   child: Container(
//                     width: 90,
//                     color: Colors.red,
//                     padding: const EdgeInsets.symmetric(vertical: 3),
//                     child: Text(
//                       "${product.discountPercent}%",
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 )
//               ],
//             ),

//             const SizedBox(width: 10),

//             /// 📄 Product Info
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [

//                   Text(
//                     product.manufacturing?.name ?? "",
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey,
//                     ),
//                   ),

//                   const SizedBox(height: 4),

//                   Text(
//                     product.name,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis, // 🔥 overflow fix
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),

//                   const SizedBox(height: 6),

//                   Row(
//                     children: [
//                       Text(
//                         "৳ ${product.discountedPrice}",
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Text(
//                         "৳ ${product.sellingPrice}",
//                         style: const TextStyle(
//                           decoration: TextDecoration.lineThrough,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 6),

//                   const Row(
//                     children: [
//                       Icon(Icons.local_shipping,
//                           size: 16, color: Colors.green),
//                       SizedBox(width: 5),
//                       Text("Delivery: "),
//                       Text(
//                         "2-3 Days",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

           
//             ElevatedButton(
//               onPressed: () async {

//                 CartItem cartItem = CartItem(
//                   userId: 15,
//                   productId: product.id,
//                   name: product.name,
//                   price: product.discountedPrice,
//                   image:
//                   "https://demoapp.ashianahealth.com/storage/products/${product.image}",
//                 );

//                 await CartService.addToCart(cartItem);

//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text("Added to Cart ✅")),
//                 );
//               },

//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 textStyle: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 elevation: 2,
//               ),

//               child: const Text("Add To Bag"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ashianahealth_mobile_app/main.dart';

// 👉 details page
import '../../Product_details/product_details.dart';

// 👉 reusable button
import '../../../widget/common/add_to_bag_button.dart';

class Categories extends StatelessWidget {
  final Product product;
    final bool outOfStock;

  const Categories({
    super.key,
    required this.product,
    this.outOfStock = false,
  });

  @override
  Widget build(BuildContext context) {

    final imageUrl =
        "https://demoapp.ashianahealth.com/storage/products/${product.image}";

    return InkWell(
      borderRadius: BorderRadius.circular(8),

      /// 🔥 CLICK → DETAILS PAGE
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(id: product.id),
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

            /// 🖼️ Product Image + Discount
            Stack(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      cacheManager: MyCacheManager.instance,
                      fit: BoxFit.cover,
                      memCacheWidth: 300,
                      memCacheHeight: 300,

                      placeholder: (context, url) => Container(
                        color: Colors.grey.shade300,
                      ),

                      errorWidget: (context, url, error) => Image.asset(
                        "assets/product.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                /// 🔥 Discount Badge
                if ((product.discountPercent ?? 0) > 0)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 90,
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                        ),
                      ),
                      child: Text(
                        "-${product.discountPercent!.toStringAsFixed(0)}%",
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

            /// 📄 Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    product.manufacturing?.name ?? "",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Text(
                        "৳ ${product.discountedPrice}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "৳ ${product.sellingPrice}",
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  const Row(
                    children: [
                      Icon(Icons.local_shipping,
                          size: 16, color: Colors.green),
                      SizedBox(width: 5),
                      Text("Delivery: "),
                      Text(
                        "2-3 Days",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            /// 🛒 Add To Bag Button (NEW)
            SizedBox(
              width: 100,
              child: AddToBagButton(
                productId: product.id,
                name: product.name,
                price: product.discountedPrice,
                image: imageUrl,
                outOfStock: outOfStock, // যদি না থাকে false দিবে
              ),
            ),
          ],
        ),
      ),
    );
  }
}