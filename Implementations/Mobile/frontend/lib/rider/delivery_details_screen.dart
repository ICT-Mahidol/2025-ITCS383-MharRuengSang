import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class DeliveryDetailsScreen extends StatelessWidget {
  const DeliveryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Delivery Details"),
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Map Placeholder
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              color: const Color(0xFFF2F4F7),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(LucideIcons.map, size: 64, color: Color(0xFFD0D5DD)),
                  ),
                  _buildMapOverlay(),
                ],
              ),
            ),
          ),
          
          // Delivery Info Card
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, -10))],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCustomerHeader(),
                    const Divider(height: 40),
                    _buildStepRow(LucideIcons.store, "Pickup", "Bangkok Street Food", "Ready for collection"),
                    _buildVerticalLine(),
                    _buildStepRow(LucideIcons.mapPin, "Drop-off", "John Doe", "123 Sukhumvit Road, Bangkok"),
                    const SizedBox(height: 32),
                    _buildActionButtons(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapOverlay() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF101828),
        child: const Icon(LucideIcons.navigation2, color: Colors.white),
      ),
    );
  }

  Widget _buildCustomerHeader() {
    return Row(
      children: [
        const CircleAvatar(radius: 24, backgroundColor: Color(0xFFF2F4F7), child: Icon(LucideIcons.user, color: Colors.black)),
        const SizedBox(width: 16),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("John Doe", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("Order #ORD001 • ฿264.00", style: TextStyle(color: Color(0xFF667085), fontSize: 13)),
            ],
          ),
        ),
        _contactBtn(LucideIcons.phone, Colors.green),
        const SizedBox(width: 8),
        _contactBtn(LucideIcons.messageSquare, Colors.blue),
      ],
    );
  }

  Widget _contactBtn(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Widget _buildStepRow(IconData icon, String label, String title, String sub) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: const Color(0xFFF2F4F7), shape: BoxShape.circle),
          child: Icon(icon, size: 16, color: Colors.black),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Color(0xFF667085), fontSize: 11, fontWeight: FontWeight.bold)),
            Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            Text(sub, style: const TextStyle(color: Color(0xFF667085), fontSize: 13)),
          ],
        ),
      ],
    );
  }

  Widget _buildVerticalLine() {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Container(width: 2, height: 30, color: const Color(0xFFEAECF0)),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Order marked as Picked Up")));
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF79009)),
            child: const Text("Confirm Pickup", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFD0D5DD)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Complete Delivery", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}