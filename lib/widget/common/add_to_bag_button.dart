// import 'package:flutter/material.dart';

// class AddToBagButton extends StatelessWidget {
//   final bool outOfStock;
//   //final int id;
//   final VoidCallback? onPressed;

//   const AddToBagButton({
//     super.key,
//    // required this.id,
//     required this.outOfStock,
//     this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 36,
//       child: ElevatedButton(
//         onPressed: () {
//           if (!outOfStock) {
//             onPressed?.call();
//           }
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: outOfStock ? Colors.red : Colors.green,
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(6),
//           ),
//           elevation: outOfStock ? 0 : 2,
//         ),
//         child: Text(
//           outOfStock ? "Out of Stock" : "Add To Bag",
//           style: const TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../models/cart_model.dart';
import '../../core/services/cart_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddToBagButton extends StatefulWidget {
  final int productId;
  final String name;
  final double price;
  final String image;
  final bool outOfStock;

  const AddToBagButton({
    super.key,
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
    required this.outOfStock,
  });

  @override
  State<AddToBagButton> createState() => _AddToBagButtonState();
}

class _AddToBagButtonState extends State<AddToBagButton> {
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    _checkIfAdded();
  }

  /// 🔍 Check if already in cart
  Future<void> _checkIfAdded() async {
    final item =
        await CartService.getCartItemByProductId(widget.productId);

    setState(() {
      if (item != null) {
        quantity = item.qty;
      } else {
        quantity = 0;
      }
    });
  }

  /// ➕ First time add
  Future<void> _handleAdd() async {
    if (widget.outOfStock) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIdString = prefs.getString('id');

    if (userIdString == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please login first")),
      );
      return;
    }

    int userId = int.parse(userIdString);

    CartItem item = CartItem(
      userId: userId,
      productId: widget.productId,
      name: widget.name,
      price: widget.price,
      image: widget.image,
      qty: 1,
    );

    await CartService.addToCart(item);

    setState(() {
      quantity = 1;
    });
  }

  /// ➕ Increase quantity
  Future<void> _increaseQty() async {
    final item =
        await CartService.getCartItemByProductId(widget.productId);

    if (item != null) {
      item.qty += 1;
      await CartService.updateCartItem(item);

      setState(() {
        quantity = item.qty;
      });
    }
  }

  /// ➖ Decrease quantity
  Future<void> _decreaseQty() async {
    final item =
        await CartService.getCartItemByProductId(widget.productId);

    if (item != null) {
      if (item.qty > 1) {
        item.qty -= 1;
        await CartService.updateCartItem(item);

        setState(() {
          quantity = item.qty;
        });
      } else {
        /// remove item
        await CartService.removeCartItem(widget.productId);

        setState(() {
          quantity = 0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    /// 🔴 Out of Stock
    if (widget.outOfStock) {
      return Container(
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Text(
          "Out of Stock",
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    /// 🟢 Not Added Yet
    if (quantity == 0) {
      return SizedBox(
        height: 36,
        child: ElevatedButton(
          onPressed: _handleAdd,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: const Text(
            "Add To Bag",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    /// 🔄 Quantity Controller
    return Container(
      height: 36,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          /// ➖ Minus
          IconButton(
            icon: const Icon(Icons.remove, size: 18),
            onPressed: _decreaseQty,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),

          /// 🔢 Quantity
          Text(
            "$quantity",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),

          /// ➕ Plus
          IconButton(
            icon: const Icon(Icons.add, size: 18),
            onPressed: _increaseQty,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import '../../models/cart_model.dart';
// import '../../core/services/cart_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AddToBagButton extends StatefulWidget {
//   final int productId;
//   final String name;
//   final double price;
//   final String image;
//   final bool outOfStock;

//   const AddToBagButton({
//     super.key,
//     required this.productId,
//     required this.name,
//     required this.price,
//     required this.image,
//     required this.outOfStock,
//   });

//   @override
//   State<AddToBagButton> createState() => _AddToBagButtonState();
// }

// class _AddToBagButtonState extends State<AddToBagButton> {
//   bool isAdded = false;

//   @override
//   void initState() {
//     super.initState();
//     _checkIfAdded();
//   }

//   Future<void> _checkIfAdded() async {
//     final item = await CartService.getCartItemByProductId(widget.productId);
//     setState(() {
//       isAdded = item != null;
//     });
//   }

//   Future<void> _handleAdd() async {
//     if (widget.outOfStock) return;

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userIdString = prefs.getString('id');

//     if (userIdString == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please login first")),
//       );
//       return;
//     }

//     int userId = int.parse(userIdString);

//     CartItem item = CartItem(
//       userId: userId,
//       productId: widget.productId,
//       name: widget.name,
//       price: widget.price,
//       image: widget.image,
//       qty: 1,
//     );

//     await CartService.addToCart(item);

//     setState(() {
//       isAdded = true;
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text("Added to cart ✅"),
//         duration: Duration(seconds: 1),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 36,
//       child: ElevatedButton(
//         onPressed: widget.outOfStock ? null : _handleAdd,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: widget.outOfStock
//               ? Colors.red
//               : isAdded
//                   ? Colors.grey
//                   : Colors.green,
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(6),
//           ),
//           elevation: widget.outOfStock ? 0 : 2,
//         ),
//         child: Text(
//           widget.outOfStock
//               ? "Out of Stock"
//               : isAdded
//                   ? "Added"
//                   : "Add To Bag",
//           style: const TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }