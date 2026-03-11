import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:fl_chart/fl_chart.dart'; // Required dependency
import '\\login_screen.dart';
import 'account_management_screen.dart';
import 'system_promotions_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

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
              
              // Revenue Metrics Row
              Row(
                children: [
                  Expanded(child: _buildStatCard("Daily Revenue", "฿125,430", "+12%", LucideIcons.dollarSign, Colors.green)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildStatCard("Active Orders", "892", "+5%", LucideIcons.shoppingCart, Colors.orange)),
                ],
              ),
              const SizedBox(height: 16),
              
              // Revenue Chart Section
              const Text("Weekly Revenue Trend", 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildRevenueChart(),
              
              const SizedBox(height: 32),
              
              // Platform Stats Grid
              const Text("Platform Overview", 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildMiniStatRow("Active Customers", "15,234", LucideIcons.users, Colors.blue),
              _buildMiniStatRow("Active Restaurants", "456", LucideIcons.store, Colors.purple),
              _buildMiniStatRow("Active Riders", "234", LucideIcons.bike, Colors.indigo),
              
              const SizedBox(height: 32),
              
              // Management Quick Actions
              const Text("Management Actions", 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildActionBtn(context, "Manage Accounts", LucideIcons.users, true, const AccountManagementScreen()),
              const SizedBox(height: 12),
              _buildActionBtn(context, "System Promotions", LucideIcons.trendingUp, false, const SystemPromotionsScreen()),
              const SizedBox(height: 40),
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
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Text("🛡️ Admin Dashboard", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text("FoodExpress Platform Management", style: TextStyle(color: Color(0xFF667085), fontSize: 13)),
        ]),
        IconButton(
          onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c) => const LoginScreen()), (r) => false),
          icon: const Icon(LucideIcons.logOut, color: Color(0xFFF04438)),
        )
      ],
    );
  }

  Widget _buildStatCard(String label, String value, String trend, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFEAECF0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(color: Color(0xFF667085), fontSize: 12)),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(trend, style: const TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMiniStatRow(String label, String value, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFEAECF0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ]),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRevenueChart() {
    return Container(
      height: 220,
      padding: const EdgeInsets.fromLTRB(10, 24, 24, 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFEAECF0))),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true, horizontalInterval: 25000, getDrawingHorizontalLine: (v) => FlLine(color: const Color(0xFFF2F4F7), strokeWidth: 1)),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: const [FlSpot(0, 45000), FlSpot(1, 52000), FlSpot(2, 48000), FlSpot(3, 70000), FlSpot(4, 85000), FlSpot(5, 95000)],
              isCurved: true,
              color: const Color(0xFF2E90FA),
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: true, color: const Color(0xFF2E90FA).withOpacity(0.1)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionBtn(BuildContext context, String label, IconData icon, bool primary, Widget target) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => target)),
        style: ElevatedButton.styleFrom(
          backgroundColor: primary ? const Color(0xFF101828) : Colors.white, 
          side: primary ? BorderSide.none : const BorderSide(color: Color(0xFFEAECF0)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: primary ? Colors.white : Colors.black, size: 18),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: primary ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }
}