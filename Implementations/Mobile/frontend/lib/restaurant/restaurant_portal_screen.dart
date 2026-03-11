import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'menu_management_screen.dart';
import 'promotions_list_screen.dart';
import '\\login_screen.dart';

class RestaurantPortalScreen extends StatelessWidget {
  const RestaurantPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 32),
              
              // Business Metrics Section
              const Text(
                "Business Overview", 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      "Orders Today", 
                      "12", 
                      LucideIcons.shoppingBag, 
                      const Color(0xFFF79009), 
                      const Color(0xFFFFFAEB)
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      "Revenue", 
                      "฿1,420", 
                      LucideIcons.banknote, 
                      const Color(0xFF12B76A), 
                      const Color(0xFFECFDF3)
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Management Actions Section
              const Text(
                "Store Management", 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 16),
              _buildManagementTile(
                context, 
                "Menu Management", 
                "Edit dishes, prices, and availability", 
                LucideIcons.utensilsCrossed, 
                const MenuManagementScreen()
              ),
              _buildManagementTile(
                context, 
                "Promotions & Marketing", 
                "Create discounts and special offers", 
                LucideIcons.megaphone, 
                const PromotionsListScreen()
              ),
              _buildManagementTile(
                context, 
                "Order History", 
                "Review past orders and performance", 
                LucideIcons.history, 
                null // Placeholder for future expansion
              ),
              
              const SizedBox(height: 40),
              _buildStoreStatusCard(),
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
              "🏪 Restaurant Portal", 
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
            ),
            Text(
              "Bangkok Street Food", 
              style: TextStyle(color: Color(0xFF667085), fontSize: 14)
            ),
          ],
        ),
        IconButton(
          onPressed: () => Navigator.pushAndRemoveUntil(
            context, 
            MaterialPageRoute(builder: (c) => const LoginScreen()), 
            (r) => false
          ),
          icon: const Icon(LucideIcons.logOut, color: Color(0xFFF04438), size: 22),
          tooltip: "Logout",
        )
      ],
    );
  }

  Widget _buildStatCard(String label, String val, IconData icon, Color iconCol, Color bg) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(16), 
        border: Border.all(color: const Color(0xFFEAECF0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: iconCol, size: 20),
          ),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(color: Color(0xFF667085), fontSize: 12)),
          const SizedBox(height: 4),
          Text(val, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildManagementTile(BuildContext context, String title, String sub, IconData icon, Widget? target) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(16), 
        border: Border.all(color: const Color(0xFFEAECF0)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10), 
          decoration: BoxDecoration(color: const Color(0xFFF2F4F7), borderRadius: BorderRadius.circular(12)), 
          child: Icon(icon, color: Colors.black, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text(sub, style: const TextStyle(fontSize: 12, color: Color(0xFF667085))),
        trailing: const Icon(LucideIcons.chevronRight, size: 18, color: Color(0xFFD0D5DD)),
        onTap: () {
          if (target != null) {
            Navigator.push(context, MaterialPageRoute(builder: (c) => target));
          }
        },
      ),
    );
  }

  Widget _buildStoreStatusCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF101828),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.store, color: Colors.white, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Store Status: Open", 
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                ),
                Text(
                  "Currently accepting new orders", 
                  style: TextStyle(color: Color(0xFF98A2B3), fontSize: 12)
                ),
              ],
            ),
          ),
          Switch(
            value: true, 
            onChanged: (v) {}, 
            activeColor: const Color(0xFF12B76A),
          ),
        ],
      ),
    );
  }
}