import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/home_provider.dart';
import '../../widget/TrendingProductCard.dart';


class TrendingProductSection extends StatelessWidget {
  final ScrollController controller;

  const TrendingProductSection({
    super.key,
    required this.controller,
  });

  void scrollLeft() {
    controller.animateTo(
      controller.offset - 220,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void scrollRight() {
    controller.animateTo(
      controller.offset + 220,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final products = provider.homeData?.data?.trendingProducts ?? [];

    return SizedBox(
      height: 270,
      child: Stack(
        children: [
          /// 🔥 Product List
          ListView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                id: product.id!,
                title: product.name ?? "",
                price: double.parse(product.discountedPrice ?? "0"),
                oldPrice: double.parse(product.sellingPrice ?? "0"),
                discount: double.parse(product.discountPercent ?? "0").toInt(),
                image: product.image ?? "",
                outOfStock: (product.stock ?? 0) <= 0,
              );
            },
          ),

          /// ⬅ Left Arrow
          Positioned(
            left: 4,
            top: 0,
            bottom: 0,
            child: Center(
              child: _arrowButton(
                icon: Icons.arrow_back_ios,
                onTap: scrollLeft,
              ),
            ),
          ),

          /// ➡ Right Arrow
          Positioned(
            right: 4,
            top: 0,
            bottom: 0,
            child: Center(
              child: _arrowButton(
                icon: Icons.arrow_forward_ios,
                onTap: scrollRight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _arrowButton({
  required IconData icon,
  required VoidCallback onTap,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6,
        )
      ],
    ),
    child: IconButton(
      icon: Icon(icon, size: 18),
      onPressed: onTap,
    ),
  );
}