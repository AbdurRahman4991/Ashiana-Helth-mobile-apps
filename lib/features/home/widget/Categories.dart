import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ashianahealth_mobile_app/main.dart';

class Categories extends StatelessWidget {
  final int id;
  final String image;

  const Categories({
    super.key,
    required this.id,
    required this.image,
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
                height: 100,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child:
                //Image.network(image, fit: BoxFit.contain),
                CachedNetworkImage(
                  imageUrl: image,
                  cacheManager: MyCacheManager.instance,
                  memCacheWidth: 300,
                  memCacheHeight: 300,
                  fit: BoxFit.cover,
                )
              ),
            ],
          ),
        ],
      ),
    );
  }
}