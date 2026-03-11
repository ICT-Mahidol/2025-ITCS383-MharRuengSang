import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PromotionsListScreen extends StatefulWidget {
  const PromotionsListScreen({super.key});

  @override
  State<PromotionsListScreen> createState() => _PromotionsListScreenState();
}

class _PromotionsListScreenState extends State<PromotionsListScreen> {
  // Mock data for restaurant-specific promotions
  final List<Map<String, dynamic>> _promos = [
    {
      "id": 1,
      "title": "Flash Sale 15%",
      "code": "FLASH15",
      "desc": "15% off on all main dishes for lunch.",
      "isActive": true,
      "discount": "15%",
    },
    {
      "id": 2,
      "title": "Free Delivery",
      "code": "FREESHIP",
      "desc": "Free delivery for orders over ฿300.",
      "isActive": false,
      "discount": "Free",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text("Promotions"),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          _buildPromoHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _promos.length,
              itemBuilder: (context, index) => _buildPromoCard(_promos[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Active Campaigns",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildAddButton(),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Manage your store's marketing campaigns and discount codes to attract more customers.",
            style: TextStyle(color: Color(0xFF667085), fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton.icon(
      onPressed: () => _showCreatePromoDialog(),
      icon: const Icon(LucideIcons.plus, size: 16, color: Colors.white),
      label: const Text("Create", style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF101828),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showCreatePromoDialog() {
    final _titleCtrl = TextEditingController();
    final _codeCtrl = TextEditingController();
    final _descCtrl = TextEditingController();
    final _discountCtrl = TextEditingController();
    bool _isActive = true;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Create Promotion'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _titleCtrl,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: _codeCtrl,
                      decoration: const InputDecoration(labelText: 'Code'),
                    ),
                    TextField(
                      controller: _descCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
                    TextField(
                      controller: _discountCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Discount (e.g. 15%)',
                      ),
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Active'),
                      value: _isActive,
                      onChanged: (val) => setState(() => _isActive = val),
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
                    if (_titleCtrl.text.trim().isEmpty ||
                        _codeCtrl.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Title and code are required'),
                        ),
                      );
                      return;
                    }
                    setState(() {
                      _promos.insert(0, {
                        'id': _promos.length + 1,
                        'title': _titleCtrl.text.trim(),
                        'code': _codeCtrl.text.trim(),
                        'desc': _descCtrl.text.trim(),
                        'isActive': _isActive,
                        'discount': _discountCtrl.text.trim().isEmpty
                            ? 'N/A'
                            : _discountCtrl.text.trim(),
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive ? const Color(0xFFF79009) : const Color(0xFFEAECF0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F4F7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  promo['code'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Switch.adaptive(
                value: isActive,
                activeColor: const Color(0xFF12B76A),
                onChanged: (val) {
                  setState(() => promo['isActive'] = val);
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            promo['title'],
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            promo['desc'],
            style: const TextStyle(color: Color(0xFF667085), fontSize: 13),
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Discount Value",
                    style: TextStyle(color: Color(0xFF98A2B3), fontSize: 11),
                  ),
                  Text(
                    promo['discount'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF12B76A),
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(
                  LucideIcons.trash2,
                  color: Color(0xFFF04438),
                  size: 20,
                ),
                onPressed: () {
                  setState(() => _promos.remove(promo));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
