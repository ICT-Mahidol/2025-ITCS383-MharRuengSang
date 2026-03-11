import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SystemPromotionsScreen extends StatefulWidget {
  const SystemPromotionsScreen({super.key});

  @override
  State<SystemPromotionsScreen> createState() => _SystemPromotionsScreenState();
}

class _SystemPromotionsScreenState extends State<SystemPromotionsScreen> {
  // Mock database for platform-wide promotions
  final List<Map<String, dynamic>> _systemPromos = [
    {
      "id": 1,
      "code": "NEWUSER50",
      "discount": "50%",
      "usage": 1240,
      "expires": "31 Dec 2026",
      "isActive": true,
      "type": "Global",
    },
    {
      "id": 2,
      "code": "FREEDELIVERY",
      "discount": "฿0 Fee",
      "usage": 450,
      "expires": "15 Apr 2026",
      "isActive": true,
      "type": "Logistics",
    },
    {
      "id": 3,
      "code": "SONGKRAN20",
      "discount": "฿20 OFF",
      "usage": 0,
      "expires": "20 Apr 2026",
      "isActive": false,
      "type": "Holiday",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                itemCount: _systemPromos.length,
                itemBuilder: (context, index) =>
                    _buildPromoCard(_systemPromos[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
              const Text(
                "System\nPromotions",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                  letterSpacing: -0.5,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFEAECF0)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: const [
                      Icon(LucideIcons.arrowLeft, size: 16),
                      SizedBox(width: 8),
                      Text(
                        "Dashboard",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildAddCodeButton(),
        ],
      ),
    );
  }

  Widget _buildAddCodeButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: _showCreateSystemPromoDialog,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF101828),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(LucideIcons.plus, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              "Create New Promotion",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateSystemPromoDialog() {
    final titleController = TextEditingController();
    final codeController = TextEditingController();
    final discountController = TextEditingController();
    final expiresController = TextEditingController();
    final typeController = TextEditingController();
    bool isActive = true;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Create System Promotion'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: codeController,
                      decoration: const InputDecoration(labelText: 'Code'),
                    ),
                    TextField(
                      controller: discountController,
                      decoration: const InputDecoration(labelText: 'Discount'),
                    ),
                    TextField(
                      controller: expiresController,
                      decoration: const InputDecoration(labelText: 'Expires'),
                    ),
                    TextField(
                      controller: typeController,
                      decoration: const InputDecoration(labelText: 'Type'),
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Active'),
                      value: isActive,
                      onChanged: (val) => setStateDialog(() => isActive = val),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.trim().isEmpty ||
                        codeController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Title and code required'),
                        ),
                      );
                      return;
                    }
                    setState(() {
                      _systemPromos.insert(0, {
                        'id': _systemPromos.length + 1,
                        'code': codeController.text.trim(),
                        'discount': discountController.text.trim().isEmpty
                            ? 'N/A'
                            : discountController.text.trim(),
                        'usage': 0,
                        'expires': expiresController.text.trim().isEmpty
                            ? 'N/A'
                            : expiresController.text.trim(),
                        'isActive': isActive,
                        'type': typeController.text.trim().isEmpty
                            ? 'Global'
                            : typeController.text.trim(),
                      });
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildPromoCard(Map<String, dynamic> promo) {
    bool isActive = promo['isActive'];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: const Color(0xFFEAECF0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _typeBadge(promo['type']),
              _statusBadge(isActive ? "Active" : "Paused"),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            promo['code'],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Discount Value: ${promo['discount']}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF12B76A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Used ${promo['usage']} times • Expires ${promo['expires']}",
            style: const TextStyle(color: Color(0xFF667085), fontSize: 13),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Switch.adaptive(
                    value: isActive,
                    activeColor: const Color(0xFF12B76A),
                    onChanged: (val) => setState(() => promo['isActive'] = val),
                  ),
                  Text(
                    isActive ? "Promo Active" : "Promo Disabled",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isActive ? Colors.black : Colors.red,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () => setState(() => _systemPromos.remove(promo)),
                icon: const Icon(
                  LucideIcons.trash2,
                  color: Color(0xFFF04438),
                  size: 18,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFFFEF3F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _typeBadge(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        type,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Color(0xFF344054),
        ),
      ),
    );
  }

  Widget _statusBadge(String status) {
    bool isPaused = status == "Paused";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isPaused ? const Color(0xFFFEF3F2) : const Color(0xFFECFDF3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: isPaused ? Colors.red : const Color(0xFF027A48),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
