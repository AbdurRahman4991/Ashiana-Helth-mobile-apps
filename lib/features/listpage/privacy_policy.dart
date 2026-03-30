import 'package:flutter/material.dart';
import '../../../widget/common/bottom_navigation_bar.dart';
import '../../../widget/common/TopNavigationBar.dart';
import '../../../widget/common/drowerRight.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: "Privacy Policy"),
      endDrawer: const DrowerRight(),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Privacy Policy for Ashiana Health"),
            _sectionText("Effective Date: 20 March, 2026"),
            _sectionText("Pharmacy Name: Ashiana Health"),
            _sectionText("Website/App: www.ashianahealth.com"),
            const Divider(height: 30),

            _sectionTitle("1. Introduction"),
            _sectionText(
                "At Ashiana Health, we value your privacy and are committed to protecting your personal and medical information when you purchase medicines from us, whether in-store or online."),
            const Divider(height: 30),

            _sectionTitle("2. Information We Collect"),
            _subSectionTitle("a. Personal Information"),
            _bulletText("Name"),
            _bulletText("Phone number"),
            _bulletText("Email address"),
            _bulletText("Delivery address"),
            _subSectionTitle("b. Health Information"),
            _bulletText("Prescription details"),
            _bulletText("Medication history"),
            _bulletText("Doctor’s name (if provided)"),
            _subSectionTitle("c. Payment Information"),
            _bulletText("Payment method (cash, mobile banking, card)"),
            _bulletText("Transaction details"),
            _subSectionTitle("d. Technical Information (for online orders)"),
            _bulletText("IP address"),
            _bulletText("Device and browser information"),
            const Divider(height: 30),

            _sectionTitle("3. How We Use Your Information"),
            _bulletText("Process and deliver medicine orders"),
            _bulletText("Verify prescriptions (if required)"),
            _bulletText("Provide customer support"),
            _bulletText("Maintain transaction records"),
            _bulletText("Improve our services"),
            _bulletText("Comply with legal and regulatory requirements"),
            const Divider(height: 30),

            _sectionTitle("4. Prescription Verification"),
            _bulletText("Require a valid prescription"),
            _bulletText("Store prescription records for compliance"),
            _bulletText("Refuse orders without proper authorization"),
            const Divider(height: 30),

            _sectionTitle("5. Sharing of Information"),
            _bulletText("With delivery partners (for order fulfillment)"),
            _bulletText("With payment service providers"),
            _bulletText("When required by law or regulatory authorities"),
            const Divider(height: 30),

            _sectionTitle("6. Data Security"),
            _bulletText("Secure storage systems"),
            _bulletText("Restricted access to sensitive information"),
            _bulletText("Encryption for online transactions"),
            const Divider(height: 30),

            _sectionTitle("7. Data Retention"),
            _bulletText("For order history and legal compliance"),
            _bulletText("As required by pharmacy regulations"),
            _bulletText("You may request deletion where legally allowed."),
            const Divider(height: 30),

            _sectionTitle("8. Your Rights"),
            _bulletText("Access your personal data"),
            _bulletText("Request correction of incorrect information"),
            _bulletText("Request deletion (subject to legal requirements)"),
            const Divider(height: 30),

            _sectionTitle("9. Cookies (For Website/App)"),
            _bulletText("Improve website functionality"),
            _bulletText("Analyze usage and performance"),
            const Divider(height: 30),

            _sectionTitle("10. Third-Party Services"),
            _bulletText("Payment gateways (bKash, Nagad, Banks)"),
            _bulletText("Delivery services"),
            _bulletText("Their privacy policies apply separately."),
            const Divider(height: 30),

            _sectionTitle("11. Children’s Privacy"),
            _sectionText(
                "We do not knowingly collect data from children without guardian consent."),
            const Divider(height: 30),

            _sectionTitle("12. Changes to This Policy"),
            _sectionText(
                "We may update this Privacy Policy at any time. Updates will be posted with a revised effective date."),
            const Divider(height: 30),

            _sectionTitle("13. Contact Information"),
            _sectionText("Ashiana Health"),
            _sectionText("Address: Dokkhinga Bazar, Sobujbag, Dhaka"),
            _sectionText("Phone: 01719552091"),
            _sectionText("Email: info@ashianahealth.com"),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _subSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _sectionText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _bulletText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 14)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}