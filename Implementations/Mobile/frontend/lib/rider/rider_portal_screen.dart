import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '\\login_screen.dart';
import 'delivery_details_screen.dart';

class RiderPortalScreen extends StatelessWidget {
  const RiderPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 32),
              
              // Rider Metrics Grid
              _buildStatCard(
                "Today's Earnings", 
                "฿0", 
                LucideIcons.dollarSign, 
                const Color(0xFF12B76A), 
                const Color(0xFFECFDF3)
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                "Completed Today", 
                "0", 
                LucideIcons.package, 
                const Color(0xFF2E90FA), 
                const Color(0xFFEFF8FF)
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                "Active Delivery", 
                "1", 
                LucideIcons.clock, 
                const Color(0xFFF79009), 
                const Color(0xFFFFFAEB)
              ),
              
              const SizedBox(height: 32),
              
              // Active Task Section
              const Text(
                "Active Delivery", 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 16),
              _buildActiveDeliveryCard(context),
              
              const SizedBox(height: 32),
              
              // Market Section
              const Text(
                "Available Orders Nearby", 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 16),
              _buildEmptyOrdersNearby(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "🚴 Rider Portal", 
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
            ),
            Text(
              "Mike Chen • Standard Rider", 
              style: TextStyle(color: Color(0xFF667085), fontSize: 14)
            ),
          ],
        ),
        _exitButton(context),
      ],
    );
  }

  Widget _exitButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(builder: (c) => const LoginScreen()), 
        (r) => false
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFEAECF0)),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          children: const [
            Icon(LucideIcons.logOut, size: 16, color: Color(0xFFF04438)),
            SizedBox(width: 8),
            Text("Exit", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color iconCol, Color bg) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEAECF0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Color(0xFF475467), fontSize: 13)),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
            child: Icon(icon, color: iconCol, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveDeliveryCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF79009), width: 1.5),
        boxShadow: [
          BoxShadow(color: Colors.orange.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Current Task", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: Color(0xFFF79009))),
              _statusBadge("In Progress"),
            ],
          ),
          const SizedBox(height: 20),
          const Text("Order #ORD001", style: TextStyle(color: Color(0xFF667085), fontSize: 12)),
          const Text("Bangkok Street Food", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 16),
          const Text("Customer", style: TextStyle(color: Color(0xFF667085), fontSize: 12)),
          const Text("John Doe", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          Row(
            children: const [
              Icon(LucideIcons.mapPin, size: 14, color: Color(0xFF667085)),
              SizedBox(width: 6),
              Text("123 Sukhumvit Road, Bangkok", style: TextStyle(fontSize: 13)),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () => Navigator.push(
                context, 
                MaterialPageRoute(builder: (c) => const DeliveryDetailsScreen())
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF101828), 
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
              ),
              child: const Text(
                "View Delivery Details", 
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFAEB),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text, 
        style: const TextStyle(color: Color(0xFFB54708), fontSize: 11, fontWeight: FontWeight.bold)
      ),
    );
  }

  Widget _buildEmptyOrdersNearby() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(20), 
        border: Border.all(color: const Color(0xFFEAECF0), style: BorderStyle.solid)
      ),
      child: Column(
        children: const [
          Icon(LucideIcons.packageSearch, size: 48, color: Color(0xFFD0D5DD)),
          SizedBox(height: 16),
          Text(
            "Searching for orders...", 
            style: TextStyle(color: Color(0xFF667085), fontWeight: FontWeight.w600)
          ),
          Text(
            "New orders will appear here automatically", 
            style: TextStyle(color: Color(0xFF98A2B3), fontSize: 12)
          ),
        ],
      ),
    );
  }
}