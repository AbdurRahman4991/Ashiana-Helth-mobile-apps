import 'package:flutter/material.dart';
import 'package:ashianahealth_mobile_app/main.dart';

class DrowerRight extends StatelessWidget {
  const DrowerRight({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Drawer header
          const UserAccountsDrawerHeader(
            accountName: Text("Abdur Rahman"),
            accountEmail: Text("engrabdurrahman4991@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/profile.jpg"),
            ),
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ),

          // Home


          // Profile
          // ListTile(
          //   leading: const Icon(Icons.person),
          //   title: const Text("Profile"),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),

          const Divider(),

          // Logout
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}