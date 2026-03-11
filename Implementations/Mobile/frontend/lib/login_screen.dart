import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'otp_screen.dart';
import 'registration_dialog.dart';
import 'models.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  UserRole _selectedRole = UserRole.customer;

  void _autoFill(String email, String password, UserRole role) {
    setState(() {
      _emailController.text = email;
      _passwordController.text = password;
      _selectedRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Changed background to solid white
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            children: [
              // Burger Icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF79009),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Text("🍔", style: TextStyle(fontSize: 40)),
              ),
              const SizedBox(height: 24),

              // Title
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Food",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF101828),
                      ),
                    ),
                    TextSpan(
                      text: "Express",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFF79009),
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                "Sign in to your account",
                style: TextStyle(color: Color(0xFF667085), fontSize: 16),
              ),
              const SizedBox(height: 32),

              // Login Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Email Address",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(
                      _emailController,
                      LucideIcons.mail,
                      "you@example.com",
                      false,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(
                      _passwordController,
                      LucideIcons.lock,
                      "••••••••",
                      true,
                    ),
                    const SizedBox(height: 24),

                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c) => OTPScreen(
                                role: _selectedRole,
                                displayName: _selectedRole.name.toUpperCase(),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF79009),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              LucideIcons.arrowRight,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    const Center(
                      child: Text(
                        "— Demo Accounts —",
                        style: TextStyle(
                          color: Color(0xFF98A2B3),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Demo Grid
                    Row(
                      children: [
                        _demoBtn(
                          "Customer",
                          LucideIcons.user,
                          () => _autoFill(
                            "customer@food.com",
                            "123456",
                            UserRole.customer,
                          ),
                        ),
                        const SizedBox(width: 12),
                        _demoBtn(
                          "Restaurant",
                          LucideIcons.utensils,
                          () => _autoFill(
                            "rest@food.com",
                            "123456",
                            UserRole.restaurant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _demoBtn(
                          "Rider",
                          LucideIcons.bike,
                          () => _autoFill(
                            "rider@food.com",
                            "123456",
                            UserRole.rider,
                          ),
                        ),
                        const SizedBox(width: 12),
                        _demoBtn(
                          "Admin",
                          LucideIcons.shieldAlert,
                          () => _autoFill(
                            "admin@food.com",
                            "123456",
                            UserRole.admin,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    const Center(
                      child: Text(
                        "Click a demo account to auto-fill credentials",
                        style: TextStyle(
                          color: Color(0xFF98A2B3),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => const RegistrationDialog(),
                          );
                        },
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: "New customer? ",
                                style: TextStyle(color: Color(0xFF667085)),
                              ),
                              TextSpan(
                                text: "Create an account →",
                                style: const TextStyle(
                                  color: Color(0xFFF79009),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "© 2026 FoodExpress · All rights reserved",
                style: TextStyle(color: Color(0xFF98A2B3), fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    IconData icon,
    String hint,
    bool isPass,
  ) {
    return TextField(
      controller: controller,
      obscureText: isPass,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, size: 20, color: const Color(0xFF98A2B3)),
        suffixIcon: isPass
            ? const Icon(LucideIcons.eye, size: 20, color: Color(0xFF98A2B3))
            : null,
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF98A2B3)),
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFEAECF0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFEAECF0)),
        ),
      ),
    );
  }

  Widget _demoBtn(String label, IconData icon, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFEAECF0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: const Color(0xFF344054)),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF344054),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
