
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../features/auth/screen/login_page.dart';
import '../../features/auth/screen/profile_edit.dart';

class DrowerRight extends StatefulWidget {
  const DrowerRight({super.key});

  @override
  State<DrowerRight> createState() => _DrowerRightState();
}

class _DrowerRightState extends State<DrowerRight> {

  String name = "";
  String phone = "";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {

    final prefs = await SharedPreferences.getInstance();

    setState(() {
      name = prefs.getString("name") ?? "";
      phone = prefs.getString("contact_no") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Column(
        children: [

          /// Drawer Header
          UserAccountsDrawerHeader(
            accountName: Text(name),
            accountEmail: Text(phone),

            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("assets/profile.webp"),
            ),

            decoration: const BoxDecoration(
              color: Colors.green,
            ),
          ),

          const Divider(),

          /// Logout
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),

            onTap: () async {

              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                    (route) => false,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Profile Edit"),

            onTap: () async {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileEdit(),
                ),
                    
              );
            },
          ),
        ],
      ),
    );
  }
}