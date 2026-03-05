import 'package:flutter/material.dart';

class Categories extends StatelessWidget {

  final String image;
  const Categories({
    super.key,
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
                child: Image.asset(image, fit: BoxFit.contain),
              ),
            ],
          ),
        ],
      ),
    );
  }
}