
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../provider/user_provider.dart';
// import '../../../widget/common/bottom_navigation_bar.dart';
// import '../../../widget/common/TopNavigationBar.dart';
// import '../../../widget/common/drowerRight.dart';
// import '../../home/screen/home.dart';

// class ProfileEdit extends StatefulWidget {
//   const ProfileEdit({super.key});

//   @override
//   State<ProfileEdit> createState() => _ProfileEditState();
// }

// class _ProfileEditState extends State<ProfileEdit> {

//   final _formKey = GlobalKey<FormState>();

//   final pharmacyController = TextEditingController();
//   final mobileController = TextEditingController();
//   final fullNameController = TextEditingController();
//   final addressController = TextEditingController();
//   final passwordController = TextEditingController();

//   bool obscurePassword = true;

//   @override
//   void initState() {
//     super.initState();
//     final provider = context.read<UserProvider>();
//     provider.fetchUser().then((_) {
//       final user = provider.user;
//       if (user != null) {
//         pharmacyController.text = user.pharmacyName;
//         mobileController.text = user.contactNo;
//         fullNameController.text = user.name;
//         addressController.text = user.address;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {

//     final provider = context.watch<UserProvider>();

//     return Scaffold(
//       appBar: const AppHeader(title: ""),
//       endDrawer: const DrowerRight(),
//       bottomNavigationBar: const CustomBottomNav(),
//       backgroundColor: const Color(0xffF5F5F5),

//       body: provider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               child: Container(
//                 padding: const EdgeInsets.all(25),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [

//                       const SizedBox(height: 25),

//                       /// Pharmacy Name
//                       const Text("Pharmacy Name *"),
//                       const SizedBox(height: 8),
//                       TextFormField(
//                         controller: pharmacyController,
//                         decoration: _inputDecoration("Enter pharmacy name", Icons.local_pharmacy),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) return "Pharmacy name is required";
//                           return null;
//                         },
//                       ),

//                       const SizedBox(height: 18),

//                       /// Mobile
//                       const Text("Mobile No *"),
//                       const SizedBox(height: 8),
//                       TextFormField(
//                         controller: mobileController,
//                         keyboardType: TextInputType.phone,
//                         decoration: _inputDecoration("Enter mobile number", Icons.phone),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) return "Mobile number is required";
//                           if (value.length != 11) return "Enter valid mobile number";
//                           return null;
//                         },
//                       ),

//                       const SizedBox(height: 18),

//                       /// Full Name
//                       const Text("Full Name *"),
//                       const SizedBox(height: 8),
//                       TextFormField(
//                         controller: fullNameController,
//                         decoration: _inputDecoration("Enter full name", Icons.person),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) return "Full name is required";
//                           return null;
//                         },
//                       ),

//                       const SizedBox(height: 18),

//                       /// Address
//                       const Text("Address *"),
//                       const SizedBox(height: 8),
//                       TextFormField(
//                         controller: addressController,
//                         maxLines: 2,
//                         decoration: _inputDecoration("Enter address", Icons.location_on),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) return "Address is required";
//                           return null;
//                         },
//                       ),

//                       const SizedBox(height: 25),

//                       /// Update Button
//                       SizedBox(
//                         width: double.infinity,
//                         height: 50,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xff4CAF50),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                           ),
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               // এখানে তুমি Update API call করতে পারবে
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(content: Text("Profile saved")),
//                               );
//                             }
//                           },
//                           child: const Text(
//                             "Update profile",
//                             style: TextStyle(fontSize: 16, color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }

//   InputDecoration _inputDecoration(String hint, IconData icon) {
//     return InputDecoration(
//       hintText: hint,
//       prefixIcon: Icon(icon),
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/user_provider.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/TopNavigationBar.dart';
import '../../../widget/common/drowerRight.dart';
import '../../home/screen/home.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final _formKey = GlobalKey<FormState>();

  final pharmacyController = TextEditingController();
  final mobileController = TextEditingController();
  final fullNameController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<UserProvider>();
    provider.fetchUser().then((_) {
      final user = provider.user;
      if (user != null) {
        pharmacyController.text = user.pharmacyName;
        mobileController.text = user.contactNo;
        fullNameController.text = user.name;
        addressController.text = user.address;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();

    return Scaffold(
      appBar: const AppHeader(title: "Edit Profile"),
      endDrawer: const DrowerRight(),
      //ottomNavigationBar: const CustomBottomNav(),
      bottomNavigationBar: CustomBottomNav(currentIndex: 1),
      backgroundColor: const Color(0xffF5F5F5),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      _buildTextField("Pharmacy Name *", pharmacyController, Icons.local_pharmacy),
                      const SizedBox(height: 18),
                      _buildTextField("Mobile No *", mobileController, Icons.phone, keyboardType: TextInputType.phone),
                      const SizedBox(height: 18),
                      _buildTextField("Full Name *", fullNameController, Icons.person),
                      const SizedBox(height: 18),
                      _buildTextField("Address *", addressController, Icons.location_on, maxLines: 2),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff4CAF50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: provider.isUpdating
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    bool success = await provider.updateProfile(
                                      name: fullNameController.text,
                                      pharmacyName: pharmacyController.text,
                                      contactNo: mobileController.text,
                                      address: addressController.text,
                                    );

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(provider.message)),
                                    );

                                    if (success) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                                      );
                                    }
                                  }
                                },
                          child: provider.isUpdating
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text("Update profile", style: TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  TextFormField _buildTextField(String label, TextEditingController controller, IconData icon,
      {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) => value!.isEmpty ? "Required" : null,
    );
  }
}