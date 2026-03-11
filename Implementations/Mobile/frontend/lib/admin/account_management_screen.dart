import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AccountManagementScreen extends StatefulWidget {
  const AccountManagementScreen({super.key});

  @override
  State<AccountManagementScreen> createState() => _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  String _activeTab = "Customers";

  // Mock Global Database for Admin control
  final List<Map<String, dynamic>> _accounts = [
    {"id": 1, "name": "John Doe", "email": "john@example.com", "detail": "+66 81 234 5678", "type": "Customers", "isEnabled": true, "status": "Active"},
    {"id": 2, "name": "Sarah Wilson", "email": "sarah@example.com", "detail": "+66 82 345 6789", "type": "Customers", "isEnabled": true, "status": "Active"},
    {"id": 3, "name": "Bangkok Street Food", "email": "Cuisine: Thai", "detail": "Rating: 4.5 ⭐", "type": "Restaurants", "isEnabled": true, "status": "Active"},
    {"id": 4, "name": "Mike Chen", "email": "mike.rider@express.com", "detail": "Vehicle: Motorbike", "type": "Riders", "isEnabled": true, "status": "Active"},
    {"id": 5, "name": "Sushi Master", "email": "Cuisine: Japanese", "detail": "Rating: 4.8 ⭐", "type": "Restaurants", "isEnabled": false, "status": "Disabled"},
  ];

  void _deleteAccount(int id) {
    setState(() {
      _accounts.removeWhere((acc) => acc['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Account permanently removed from system")),
    );
  }

  void _toggleAccount(int id, bool value) {
    setState(() {
      final index = _accounts.indexWhere((acc) => acc['id'] == id);
      _accounts[index]['isEnabled'] = value;
      _accounts[index]['status'] = value ? "Active" : "Disabled";
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _accounts.where((acc) => acc['type'] == _activeTab).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopNavigation(context),
            _buildCustomTabSelector(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemCount: filteredList.length,
                itemBuilder: (context, index) => _buildPremiumAccountCard(filteredList[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNavigation(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Account\nManagement", 
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, height: 1.1, letterSpacing: -0.5)),
              _smallActionBtn(LucideIcons.layoutDashboard, "Dashboard", () => Navigator.pop(context)),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: "Search name, email, or ID...",
              prefixIcon: const Icon(LucideIcons.search, size: 18),
              filled: true,
              fillColor: const Color(0xFFF2F4F7),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomTabSelector() {
    final tabs = ["Customers", "Restaurants", "Riders"];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(color: const Color(0xFFEAECF0), borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: tabs.map((tab) {
          bool isSelected = _activeTab == tab;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _activeTab = tab),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isSelected ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)] : [],
                ),
                child: Center(
                  child: Text(tab, style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? Colors.black : const Color(0xFF667085),
                  )),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPremiumAccountCard(Map<String, dynamic> acc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20, offset: const Offset(0, 10))],
        border: Border.all(color: const Color(0xFFF2F4F7)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFFF2F4F7),
                child: Text(acc['name'][0], style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(acc['name'], style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text(acc['email'], style: const TextStyle(color: Color(0xFF667085), fontSize: 13)),
                    Text(acc['detail'], style: const TextStyle(color: Color(0xFF667085), fontSize: 13)),
                  ],
                ),
              ),
              _statusBadge(acc['status']),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider(height: 1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Switch.adaptive(
                    value: acc['isEnabled'],
                    activeColor: const Color(0xFF12B76A),
                    onChanged: (val) => _toggleAccount(acc['id'], val),
                  ),
                  Text(acc['isEnabled'] ? "Account Enabled" : "Access Revoked", 
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: acc['isEnabled'] ? Colors.black : Colors.red)),
                ],
              ),
              IconButton(
                onPressed: () => _deleteAccount(acc['id']),
                icon: const Icon(LucideIcons.trash2, color: Color(0xFFF04438), size: 20),
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFFFEF3F2), 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _smallActionBtn(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(border: Border.all(color: const Color(0xFFEAECF0)), borderRadius: BorderRadius.circular(12)),
        child: Row(children: [Icon(icon, size: 16), const SizedBox(width: 6), Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),
      ),
    );
  }

  Widget _statusBadge(String status) {
    bool isRed = status == "Disabled" || status == "Suspended";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: isRed ? const Color(0xFFFEF3F2) : const Color(0xFFF2F4F7), borderRadius: BorderRadius.circular(8)),
      child: Text(status, style: TextStyle(color: isRed ? Colors.red : Colors.black, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }
}