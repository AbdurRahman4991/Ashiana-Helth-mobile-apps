// import 'package:flutter/material.dart';
// import 'core/storage/local_storage.dart';
// import 'features/home/screen/home.dart';
// import '../../../features/auth/screen/login_page.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//
//   @override
//   void initState() {
//     super.initState();
//     checkLogin();
//   }
//
//   void checkLogin() async {
//
//     String? token = await LocalStorage.getToken();
//
//     await Future.delayed(const Duration(seconds: 2));
//
//     if (token != null) {
//
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const HomeScreen()),
//       );
//
//     } else {
//
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const LoginPage()),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'core/storage/local_storage.dart';
import 'features/home/screen/home.dart';
import 'features/auth/screen/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animation setup
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    checkLogin();
  }

  void checkLogin() async {
    String? token = await LocalStorage.getToken();

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return; // ✅ important

    if (token != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // ✅ clean memory
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔥 App Logo
              Image.asset(
                "assets/icon/app_icon.png", // তোমার logo path
                height: 120,
              ),

              const SizedBox(height: 20),

              // 🔄 Loading indicator
              const CircularProgressIndicator(),

              const SizedBox(height: 10),

              const Text(
                "Loading...",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}