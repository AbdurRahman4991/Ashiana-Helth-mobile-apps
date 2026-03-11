// import 'package:flutter/material.dart';
//
// class Categories extends StatelessWidget {
//   const Categories({super.key});
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
//               Container(
//                 width: 90,
//                 height: 90,
//                 padding: const EdgeInsets.all(8),
//                 child: Image.asset("assets/product.png"),
//               ),
//
//               Positioned(
//                 bottom: 0,
//                 child: Container(
//                   width: 90,
//                   color: Colors.red,
//                   padding: const EdgeInsets.symmetric(vertical: 3),
//                   child: const Text(
//                     "15.00%",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.white),
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
//                 const Text(
//                   "Square Pharmaceuticals LTD.",
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey,
//                   ),
//                 ),
//
//                 const SizedBox(height: 4),
//
//                 const Text(
//                   "Capsule Arubin 500 mg",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//
//                 const SizedBox(height: 6),
//
//                 Row(
//                   children: const [
//                     Text(
//                       "৳ 106.25",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Text(
//                       "৳ 125.00",
//                       style: TextStyle(
//                         decoration: TextDecoration.lineThrough,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 6),
//
//                 const Row(
//                   children: [
//                     Icon(Icons.local_shipping,
//                         size: 16, color: Colors.green),
//                     SizedBox(width: 5),
//                     Text("Delivery: "),
//                     Text(
//                       "6 Mar 2:00 PM",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//
//           /// Button
//          ElevatedButton(
//               onPressed: () {
//                 // Add to bag action
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,   // Button background
//                 foregroundColor: Colors.white,   // Text color
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // ছোট button
//                 textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(6), // Rounded corners
//                 ),
//                 elevation: 2, // shadow
//               ),
//               child: const Text("Add To Bag"),
//             )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../models/product_model.dart';

class Categories extends StatelessWidget {

  final Product product;

  const Categories({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
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

          /// Product Image
          Stack(
            children: [
              Container(
                width: 90,
                height: 90,
                padding: const EdgeInsets.all(8),
                child: Image.network(
                  "http://127.0.0.1:8000/uploads/${product.image}",
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                bottom: 0,
                child: Container(
                  width: 90,
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(
                    "${product.discountPercent ?? "0"}%",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),

          const SizedBox(width: 10),

          /// Product Info
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
                  product.name ?? "",
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

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              textStyle: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w500),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text("Add To Bag"),
          )
        ],
      ),
    );
  }
}