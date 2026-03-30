import 'package:ashianahealth_mobile_app/features/auth/screen/forget_password.dart';
import 'package:flutter/material.dart';
import '../../../provider/login_provider.dart';
import '../../../features/auth/screen/create_account_page.dart';
import '../../../features/home/screen/home.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff4CAF50), Color(0xff2E7D32)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.all(25),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  )
                ],
              ),

              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Center(
                      child: Text(
                        "Welcome Back 👋",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Center(
                      child: Text(
                        "Login to your account",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// PHONE FIELD
                    const Text("Phone"),
                    const SizedBox(height: 8),

                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Enter your phone",
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Phone number required";
                        }

                        if (value.length != 11) {
                          return "Phone must be 11 digits";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    /// PASSWORD FIELD
                    const Text("Password"),
                    const SizedBox(height: 8),

                    TextFormField(
                      controller: passwordController,
                      obscureText: obscurePassword,

                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        prefixIcon: const Icon(Icons.lock_outline),

                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),

                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password required";
                        }

                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 10),

                    /// REMEMBER + FORGOT
                    Row(
                      children: [

                        Checkbox(
                          value: rememberMe,
                          onChanged: (v) {
                            setState(() {
                              rememberMe = v ?? false;
                            });
                          },
                        ),

                        const Text("Remember me"),

                        const Spacer(),

                        TextButton(
                          onPressed: () {
                            Navigator.push(context,
                            MaterialPageRoute(builder: (_)  => ForgetPasswordPage())
                            );
                          },
                          child: const Text("Forgot Password?"),
                        )
                      ],
                    ),

                    const SizedBox(height: 15),

                    /// LOGIN BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 50,

                      child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff4CAF50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        // onPressed: provider.isLoading
                        //     ? null
                        //     : () async {
                        //   if (_formKey.currentState!.validate()) {
                        //     bool success = await provider.login(
                        //       emailController.text,
                        //       passwordController.text,
                        //     );
                        //
                        //     if (success) {
                        //       Navigator.pushReplacement(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (_) => const HomeScreen(),
                        //         ),
                        //       );
                        //     } else {
                        //       ScaffoldMessenger.of(context).showSnackBar(
                        //         const SnackBar(
                        //             content: Text("Login Failed")),
                        //       );
                        //     }
                        //   }
                        // },
                        onPressed: provider.isLoading ? null : () async {
                          if (_formKey.currentState!.validate()) {
                            bool success = await provider.login(
                              emailController.text,
                              passwordController.text,
                            );

                            // ✅ server থেকে আসা message দেখানো
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(provider.message)),
                            );

                            if (success) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomeScreen(),
                                ),
                              );
                            }
                          }
                        },

                        child: provider.isLoading
                            ? const CircularProgressIndicator(
                            color: Colors.white)
                            : const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// SIGNUP
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        const Text("Don't have an account? "),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const CreateAccountPage(),
                              ),
                            );
                          },

                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Color(0xff4e73df),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}