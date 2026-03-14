
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final double oldPrice;
  final int discount;
  final String image;
  final bool outOfStock;

  const ProductCard({
    super.key,
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

          /// Image + Discount
          Stack(
            children: [
              Container(
                width: 90,
                height: 90,
                padding: const EdgeInsets.all(8),
                child: Image.network(image, fit: BoxFit.contain),
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

          /// Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
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

                ElevatedButton(
                  onPressed: outOfStock ? null : () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    outOfStock ? Colors.red : Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(outOfStock ? "Out of Stock" : "Add To Bag"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}