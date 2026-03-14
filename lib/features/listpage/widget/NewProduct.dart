
import 'package:flutter/material.dart';
import '../../../models/product_model.dart';
import '../../../models/cart_model.dart';
import '../../../core/services/cart_service.dart';

class NewProduct extends StatelessWidget {
  final Product product; // dynamic data

  const NewProduct({super.key, required this.product});

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

          /// Product Image + Discount
          Stack(
            children: [
              Container(
                width: 90,
                height: 90,
                padding: const EdgeInsets.all(8),
                child: Image.network(
                  product.image.isNotEmpty
                      ? "http://127.0.0.1:8000/storage/${product.image}"
                      : "https://via.placeholder.com/90",
                  fit: BoxFit.cover,
                ),
              ),

              if (product.discountPercent != null && product.discountPercent! > 0)
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 90,
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      "${product.discountPercent!.toStringAsFixed(2)}%",
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
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    Text(
                      "৳ ${product.discountedPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    if (product.sellingPrice != product.discountedPrice)
                      Text(
                        "৳ ${product.sellingPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          /// Button
          ElevatedButton(
            onPressed: () async {

              CartItem cartItem = CartItem(
                userId: 15,
                productId: product.id,
                name: product.name,
                price: product.discountedPrice,
                image: "http://10.0.2.2:8000/storage/products/${product.image}",
              );

              await CartService.addToCart(cartItem);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Added to Cart")),
              );

            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              elevation: 2,
            ),
            child: const Text("Add To Bag"),
          ),


        ],
      ),
    );
  }
}