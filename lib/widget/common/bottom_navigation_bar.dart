import 'package:flutter/material.dart';
import '../../features/order/AddToCard.dart';
import '../../features/order/OrderList.dart';
import '../../features/home/screen/home.dart';
import '../../../core/services/cart_service.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({Key? key}) : super(key: key);

  void _onItemTapped(BuildContext context, int index) {

    if (index == 0) { // Bag icon
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }

    if (index == 2) { // Bag icon
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BagPage(),
        ),
      );
    }
    if (index == 3) { // Orders icon
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrdersPage(),
      ),
    );
  }

  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,

      onTap: (index) {
        _onItemTapped(context, index);
      },

      // items: const [
      //   BottomNavigationBarItem(
      //     icon: Icon(Icons.home),
      //     label: "Home",
      //   ),
      //   BottomNavigationBarItem(
      //     icon: Icon(Icons.flash_on),
      //     label: "Shortcuts",
      //   ),
      //   // BottomNavigationBarItem(
      //   //   icon: Icon(Icons.shopping_bag),
      //   //   label: "Bag",
      //   // ),
      //   BottomNavigationBarItem(
      //     icon: ValueListenableBuilder(
      //       valueListenable: CartService.cartCount,
      //       builder: (context, int count, child) {
      //         return Stack(
      //           children: [
      //             const Icon(Icons.shopping_bag),
      //             if (count > 0)
      //               Positioned(
      //                 right: 0,
      //                 top: 0,
      //                 child: Container(
      //                   padding: const EdgeInsets.all(4),
      //                   decoration: BoxDecoration(
      //                     color: Colors.red,
      //                     borderRadius: BorderRadius.circular(10),
      //                   ),
      //                   child: Text(
      //                     "$count",
      //                     style: const TextStyle(
      //                       color: Colors.white,
      //                       fontSize: 10,
      //                     ),
      //                   ),
      //                 ),
      //               )
      //           ],
      //         );
      //       },
      //     ),
      //     label: "Bag",
      //   ),
      //   BottomNavigationBarItem(
      //     icon: Icon(Icons.receipt),
      //     label: "Orders",
      //   ),
      //   // BottomNavigationBarItem(
      //   //   icon: Icon(Icons.person),
      //   //   label: "Profile",
      //   // ),
      // ],
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.flash_on),
          label: "Shortcuts",
        ),
        BottomNavigationBarItem(
          icon: ValueListenableBuilder(
            valueListenable: CartService.cartCount,
            builder: (context, int count, child) {
              return Stack(
                children: [
                  const Icon(Icons.shopping_bag),
                  if (count > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "$count",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    )
                ],
              );
            },
          ),
          label: "Bag",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.receipt),
          label: "Orders",
        ),
      ],
    );
  }
}