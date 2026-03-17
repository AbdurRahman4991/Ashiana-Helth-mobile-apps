

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ashianahealth_mobile_app/main.dart';

class Menufacturers extends StatelessWidget {
  final String image;
  final String name;
  final String manufacturerName;
  final double sellingPrice;
  final double discountedPrice;
  final double discountPercent;


  const Menufacturers({
    super.key,
    required this.image,
    required this.name,
    required this.manufacturerName,
    required this.sellingPrice,
    required this.discountedPrice,
    required this.discountPercent,
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

          /// Product Image + Discount
          Stack(
            children: [
              // Container(
              //   width: 90,
              //   height: 90,
              //   padding: const EdgeInsets.all(8),
              //   child: Image.network(
              //     "http://127.0.0.1:8000/storage/products/$image",
              //     fit: BoxFit.cover,
              //   ),
              // ),


              Container(
                width: 90,
                height: 90,
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: "https://demoapp.ashianahealth.com/storage/products/$image",

                    cacheManager: MyCacheManager.instance,
                    fit: BoxFit.cover,

                    memCacheWidth: 300,
                    memCacheHeight: 300,

                    // loading
                    placeholder: (context, url) => Container(
                      color: Colors.grey.shade300,
                    ),

                    // error হলে fallback
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/product.png",
                      fit: BoxFit.cover,
                    ),

                    fadeInDuration: const Duration(milliseconds: 300),
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
                    "$discountPercent%",
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
                  manufacturerName,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    Text(
                      "৳ $discountedPrice",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "৳ $sellingPrice",
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
                      "6 Mar 2:00 PM",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// Button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              textStyle:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              elevation: 2,
            ),
            child: const Text("Add To Bag"),
          )
        ],
      ),
    );
  }
}