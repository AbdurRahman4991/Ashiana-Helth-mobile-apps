import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateAccountPage(),
    );
  }
}

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final pharmacyController = TextEditingController();
  final mobileController = TextEditingController();
  final fullNameController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            //colors: [Color(0xff4e73df), Color(0xff224abe)],
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Center(
                    child: Text(
                      "Create Account 📝",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Pharmacy Name
                  const Text("Pharmacy Name *"),
                  const SizedBox(height: 8),
                  TextField(
                    controller: pharmacyController,
                    decoration: _inputDecoration("Enter pharmacy name", Icons.local_pharmacy),
                  ),

                  const SizedBox(height: 18),

                  // Mobile
                  const Text("Mobile No *"),
                  const SizedBox(height: 8),
                  TextField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    decoration: _inputDecoration("Enter mobile number", Icons.phone),
                  ),

                  const SizedBox(height: 18),

                  // Full Name
                  const Text("Full Name *"),
                  const SizedBox(height: 8),
                  TextField(
                    controller: fullNameController,
                    decoration: _inputDecoration("Enter full name", Icons.person),
                  ),

                  const SizedBox(height: 18),

                  // Address
                  const Text("Address *"),
                  const SizedBox(height: 8),
                  TextField(
                    controller: addressController,
                    maxLines: 2,
                    decoration: _inputDecoration("Enter address", Icons.location_on),
                  ),

                  const SizedBox(height: 18),

                  // Password
                  const Text("Password *"),
                  const SizedBox(height: 8),
                  TextField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      hintText: "Enter password",
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
                  ),

                  const SizedBox(height: 25),

                  // Create Button
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
                      onPressed: () {
                        print("Pharmacy: ${pharmacyController.text}");
                        print("Mobile: ${mobileController.text}");
                        print("Name: ${fullNameController.text}");
                        print("Address: ${addressController.text}");
                        print("Password: ${passwordController.text}");
                      },
                      child: const Text(
                        "Create Account",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Login",
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
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}