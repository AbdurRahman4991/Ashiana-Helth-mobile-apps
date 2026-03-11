import 'package:flutter/material.dart';
import '../../../widget/common/add_to_bag_button.dart';

class NewProductCard extends StatelessWidget {
  final String title;
  final double price;
  final double oldPrice;
  final int discount;
  final String image;
  final bool outOfStock;

  const NewProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    this.outOfStock = false, // default: in stock
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

          /// Image + Discount Badge
          Stack(
            children: [
              Container(
                height: 130,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Image.asset(image, fit: BoxFit.contain),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Product Name
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),

                /// Price Row
                Row(
                  children: [
                    Text(
                      "৳ $price",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "৳ $oldPrice",
                      style: const TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                /// Button Widget
                // SizedBox(
                //   width: double.infinity,
                //   height: 36,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       if (!outOfStock) {
                //         // Add to bag action
                //       }
                //     },
                //     style: ElevatedButton.styleFrom(
                //
                //       backgroundColor: outOfStock ? Colors.red : Colors.green,
                //       foregroundColor: Colors.white,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(6),
                //       ),
                //       elevation: outOfStock ? 0 : 2,
                //     ),
                //     child: Text(outOfStock ? "Out of Stock" : "Add To Bag", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,),),
                //   ),
                // ),
                AddToBagButton(
                  outOfStock: outOfStock,
                  onPressed: () {
                    print("Add to cart clicked");
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}