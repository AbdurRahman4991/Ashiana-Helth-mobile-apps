import 'package:flutter/material.dart';
import '../../../widget/common/add_to_bag_button.dart';
import '../../../core/services/cart_service.dart';
import '../../../models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewProductCard extends StatelessWidget {
  final int id;
  final String title;
  final double price;
  final double oldPrice;
  final int discount;
  final String image;
  final bool outOfStock;

  const NewProductCard({
    super.key,
    required this.id,
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

                  AddToBagButton(
                    outOfStock: outOfStock,
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      String? userIdString = prefs.getString('id'); // লগইন ইউজারের আইডি

                      if (userIdString != null) {
                        int userId = int.parse(userIdString); // String থেকে int-এ রূপান্তর

                        CartItem item = CartItem(
                          userId: userId, // এখন int টাইপ
                          productId: id!,
                          name: title,
                          price: price,
                          image: image,
                        );

                        await CartService.addToCart(item);
                        print("Product added to cart");
                      } else {
                        print("User not logged in");
                      }
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