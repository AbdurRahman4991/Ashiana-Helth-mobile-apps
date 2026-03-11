import 'package:flutter/material.dart';

class AddToBagButton extends StatelessWidget {
  final bool outOfStock;
  final VoidCallback? onPressed;

  const AddToBagButton({
    super.key,
    required this.outOfStock,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 36,
      child: ElevatedButton(
        onPressed: () {
          if (!outOfStock) {
            onPressed?.call();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: outOfStock ? Colors.red : Colors.green,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: outOfStock ? 0 : 2,
        ),
        child: Text(
          outOfStock ? "Out of Stock" : "Add To Bag",
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

