import 'package:flutter/material.dart';

class RegistrationSheet extends StatelessWidget {
  const RegistrationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Back to Login Header
            TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 18),
              label: const Text("Back to Login", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            const Text("Customer Registration", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text("Create your account to start ordering", style: TextStyle(color: Colors.grey)),
            
            const SizedBox(height: 30),
            _sectionHeader("Personal Information"),
            Row(
              children: [
                Expanded(child: _buildInputField("First Name *", "")),
                const SizedBox(width: 15),
                Expanded(child: _buildInputField("Last Name *", "")),
              ],
            ),
            _buildInputField("Email *", ""),
            _buildInputField("Mobile Number *", "+66 XX XXX XXXX", helper: "Required for OTP authentication"),
            _buildInputField("Delivery Address *", "Street, District, City"),

            const SizedBox(height: 25),
            _sectionHeader("Account Security"),
            _buildInputField("Password *", "", isPassword: true, helper: "Must be updated every month"),
            _buildInputField("Confirm Password *", "", isPassword: true),

            const SizedBox(height: 25),
            _sectionHeader("Payment Information"),
            _buildInputField("Credit Card Number *", "1234 5678 9012 3456"),
            Row(
              children: [
                Expanded(child: _buildInputField("Expiry Date *", "MM/YY")),
                const SizedBox(width: 15),
                Expanded(child: _buildInputField("CVV *", "123")),
              ],
            ),

            const SizedBox(height: 30),
            // Create Account Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Create Account", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildInputField(String label, String hint, {bool isPassword = false, String? helper}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 8),
          TextField(
            obscureText: isPassword,
            style: const TextStyle(color: Colors.black), // Black text when typing
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFFB0B0B0)),
              filled: true,
              fillColor: const Color(0xFFF2F4F7), // Light grey box from screenshot
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
            ),
          ),
          if (helper != null) ...[
            const SizedBox(height: 4),
            Text(helper, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ]
        ],
      ),
    );
  }
}