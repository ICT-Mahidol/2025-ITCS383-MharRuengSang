import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class RegistrationDialog extends StatelessWidget {
  const RegistrationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: const [
                    Icon(LucideIcons.arrowLeft, size: 18),
                    SizedBox(width: 8),
                    Text("Back to Login", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text("Customer Registration", 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
              const Text("Create your account to start ordering", 
                style: TextStyle(color: Color(0xFF667085), fontSize: 15)),
              
              const SizedBox(height: 32),
              
              // Personal Information Section
              _sectionTitle("Personal Information"),
              Row(
                children: [
                  Expanded(child: _labeledField("First Name *", "e.g. John")),
                  const SizedBox(width: 12),
                  Expanded(child: _labeledField("Last Name *", "e.g. Doe")),
                ],
              ),
              _labeledField("Email *", "you@example.com"),
              _labeledField("Mobile Number *", "+66 XX XXX XXXX", 
                footer: "Required for OTP authentication"),
              _labeledField("Delivery Address *", "Street, District, City"),

              const SizedBox(height: 24),
              
              // Account Security Section
              _sectionTitle("Account Security"),
              _labeledField("Password *", "••••••••", isPass: true, 
                footer: "Must be updated every month"),
              _labeledField("Confirm Password *", "••••••••", isPass: true),

              const SizedBox(height: 24),
              
              // Payment Information Section
              _sectionTitle("Payment Information"),
              _labeledField("Credit Card Number *", "1234 5678 9012 3456"),
              Row(
                children: [
                  Expanded(child: _labeledField("Expiry Date *", "MM/YY")),
                  const SizedBox(width: 12),
                  Expanded(child: _labeledField("CVV *", "123")),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF79009),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Create Account", 
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _labeledField(String label, String hint, {String? footer, bool isPass = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 8),
          TextField(
            obscureText: isPass,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF98A2B3), fontSize: 14),
              filled: true,
              fillColor: const Color(0xFFF9FAFB),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          if (footer != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(footer, style: const TextStyle(color: Color(0xFF98A2B3), fontSize: 11)),
            ),
        ],
      ),
    );
  }
}