
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../features/auth/screen/login_page.dart';
import '../../features/auth/screen/profile_edit.dart';
import '../../provider/user_provider.dart';
import '../../features/listpage/privacy_policy.dart';

class DrowerRight extends StatefulWidget {
  const DrowerRight({super.key});

  @override
  State<DrowerRight> createState() => _DrowerRightState();
}

class _DrowerRightState extends State<DrowerRight> {

  @override
  void initState() {
    super.initState();

    /// API Call
    Future.microtask(() =>
        Provider.of<UserProvider>(context, listen: false).fetchUser());

  }

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserProvider>(context);

    final name = userProvider.user?.name ?? "";
    final phone = userProvider.user?.contactNo ?? "";

    return Drawer(
      child: Column(
        children: [

          /// Header
          userProvider.isLoading
              ? const Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(),
          )
              : UserAccountsDrawerHeader(
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

          /// Profile Edit
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Profile Edit"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileEdit(),
                ),
              );
            },
          ),
                    ListTile(
            leading: const Icon(Icons.security),
            title: const Text("Privacy Policy"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyPage(),
                ),
              );
            },
          ),
           ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                    (route) => false,
              );
            },
          ),

        ],
      ),
    );
  }
}