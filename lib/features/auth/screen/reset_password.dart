import 'package:ashianahealth_mobile_app/features/auth/screen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/reset_password_provider.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/TopNavigationBar.dart';
import '../../../widget/common/drowerRight.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   // final provider = context.watch<UserProvider>();
    final provider = context.watch<ResetPasswordProvider>();

    return Scaffold(
      appBar: const AppHeader(title: "Reset Password"),
      endDrawer: const DrowerRight(),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 25),

                      // Old Password
                      TextFormField(
                        controller: oldPassController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Old Password",
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Required" : null,
                      ),
                      const SizedBox(height: 18),

                      // New Password
                      TextFormField(
                        controller: newPassController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "New Password",
                          prefixIcon: Icon(Icons.lock_outline),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Required" : null,
                      ),
                      const SizedBox(height: 18),

                      // Confirm Password
                      TextFormField(
                        controller: confirmPassController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Confirm Password",
                          prefixIcon: Icon(Icons.lock_outline),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return "Required";
                          if (value != newPassController.text)
                            return "Passwords do not match";
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff4CAF50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: provider.isLoading
    ? null
    : () async {
        if (_formKey.currentState!.validate()) {
          bool success = await provider.changePassword(
            oldPassword: oldPassController.text,
            newPassword: newPassController.text,
            confirmPassword: confirmPassController.text,
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(provider.message)),
          );

       if (success) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const LoginPage(),
    ),
  );
}
        }
      },
                          child: provider.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text("Change Password",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}