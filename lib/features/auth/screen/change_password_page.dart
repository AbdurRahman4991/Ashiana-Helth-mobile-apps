//
// import 'package:flutter/material.dart';
//
// class ChangePasswordPage extends StatefulWidget {
//   const ChangePasswordPage({super.key});
//
//   @override
//   State<ChangePasswordPage> createState() => _ChangePasswordPageState();
// }
//
// class _ChangePasswordPageState extends State<ChangePasswordPage> {
//   final _formKey = GlobalKey<FormState>();
//   final passwordController = TextEditingController();
//   final confirmController = TextEditingController();
//
//   bool obscurePassword = true;
//   bool obscureConfirm = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Change Password")),
//       body: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               const SizedBox(height: 30),
//               TextFormField(
//                 controller: passwordController,
//                 obscureText: obscurePassword,
//                 decoration: InputDecoration(
//                   labelText: "New Password",
//                   prefixIcon: const Icon(Icons.lock_outline),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                         obscurePassword ? Icons.visibility_off : Icons.visibility),
//                     onPressed: () {
//                       setState(() {
//                         obscurePassword = !obscurePassword;
//                       });
//                     },
//                   ),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                 ),
//                 validator: (v) {
//                   if (v == null || v.isEmpty) return "Enter new password";
//                   if (v.length < 6) return "Password must be at least 6 characters";
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: confirmController,
//                 obscureText: obscureConfirm,
//                 decoration: InputDecoration(
//                   labelText: "Confirm Password",
//                   prefixIcon: const Icon(Icons.lock_outline),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                         obscureConfirm ? Icons.visibility_off : Icons.visibility),
//                     onPressed: () {
//                       setState(() {
//                         obscureConfirm = !obscureConfirm;
//                       });
//                     },
//                   ),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                 ),
//                 validator: (v) {
//                   if (v == null || v.isEmpty) return "Confirm your password";
//                   if (v != passwordController.text) return "Passwords do not match";
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xff4CAF50),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12))),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("Password changed successfully!")),
//                       );
//                       Navigator.popUntil(context, (route) => route.isFirst);
//                     }
//                   },
//                   child: const Text(
//                     "Change Password",
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/change_password_provider.dart';

class ChangePasswordPage extends StatefulWidget {
  final String phone; // OTP verified phone
  final String otp;
  const ChangePasswordPage({super.key, required this.phone,  required this.otp,});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChangePasswordProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Change Password")),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),

              /// New Password
              TextFormField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  labelText: "New Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return "Enter new password";
                  if (v.length < 6)
                    return "Password must be at least 6 characters";
                  return null;
                },
              ),
              const SizedBox(height: 20),

              /// Confirm Password
              TextFormField(
                controller: confirmController,
                obscureText: obscureConfirm,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(obscureConfirm
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        obscureConfirm = !obscureConfirm;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return "Confirm your password";
                  if (v != passwordController.text)
                    return "Passwords do not match";
                  return null;
                },
              ),
              const SizedBox(height: 30),

              /// Change Password Button
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
                      bool success = await provider.resetPassword(
                        phone: widget.phone,
                        otp: widget.otp,
                        password: passwordController.text,
                        confirmPassword: confirmController.text,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(provider.message)),
                      );

                      if (success) {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      }
                    }
                  },
                  child: provider.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    "Change Password",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}