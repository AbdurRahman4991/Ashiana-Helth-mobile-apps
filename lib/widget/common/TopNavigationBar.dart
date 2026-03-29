// import 'package:flutter/material.dart';
//
// class AppHeader extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//
//   const AppHeader({super.key, required this.title});
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 1,
//       title: Text(
//         title,
//         style: const TextStyle(
//           color: Colors.black,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.notifications, color: Colors.black),
//           onPressed: () {},
//         ),
//         // IconButton(
//         //   icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
//         //   onPressed: () {},
//         // ),
//         IconButton(
//           icon: const Icon(Icons.menu, color: Colors.black), // Hamburger for right drawer
//           onPressed: () {
//             Scaffold.of(context).openEndDrawer(); // Open right drawer
//           },
//         ),
//       ],
//     );
//   }
//
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? logoPath; // logo asset path

  const AppHeader({super.key, required this.title, this.logoPath = "assets/icon/app_icon.png"});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,

      /// 🔹 Logo on the left
      leading: logoPath != null
          ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          logoPath!,
          fit: BoxFit.contain,
        ),
      )
          : null, // যদি logo না দেওয়া থাকে

      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.black),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.black), // Hamburger for right drawer
          onPressed: () {
            Scaffold.of(context).openEndDrawer(); // Open right drawer
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}