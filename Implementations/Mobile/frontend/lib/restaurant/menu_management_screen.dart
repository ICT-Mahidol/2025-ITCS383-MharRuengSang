import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MenuManagementScreen extends StatefulWidget {
  const MenuManagementScreen({super.key});

  @override
  State<MenuManagementScreen> createState() => _MenuManagementScreenState();
}

class _MenuManagementScreenState extends State<MenuManagementScreen> {
  // Mock menu database for the portal
  final List<Map<String, dynamic>> _menuItems = [
    {
      "id": 1,
      "name": "Pad Thai",
      "price": "120",
      "desc": "Stir-fried rice noodles with shrimp and peanuts",
      "cat": "Main"
    },
    {
      "id": 2,
      "name": "Spring Rolls",
      "price": "80",
      "desc": "Crispy vegetable rolls served with sweet chili sauce",
      "cat": "Appetizer"
    },
    {
      "id": 3,
      "name": "Iced Lemon Tea",
      "price": "45",
      "desc": "Freshly brewed tea with honey and lemon",
      "cat": "Beverage"
    },
  ];

  void _deleteItem(int index) {
    setState(() {
      _menuItems.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Item removed from menu")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text("Menu Management"),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.circlePlus, color: Color(0xFFF79009)),
            onPressed: () => _showItemDialog(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _buildMenuStats(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                final item = _menuItems[index];
                return _buildMenuItemCard(item, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuStats() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        children: [
          _statItem("Total Items", _menuItems.length.toString()),
          const VerticalDivider(),
          _statItem("Categories", "3"),
          const VerticalDivider(),
          _statItem("Active", _menuItems.length.toString()),
        ],
      ),
    );
  }

  Widget _statItem(String label, String val) {
    return Expanded(
      child: Column(
        children: [
          Text(val, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Color(0xFF667085), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildMenuItemCard(Map<String, dynamic> item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEAECF0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(LucideIcons.image, color: Color(0xFFD0D5DD)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 2),
                Text(
                  item['desc'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Color(0xFF667085), fontSize: 13),
                ),
                const SizedBox(height: 8),
                Text(
                  "฿${item['price']}",
                  style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF101828)),
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(LucideIcons.pencil, size: 18, color: Color(0xFF475467)),
                onPressed: () => _showItemDialog(item: item, index: index),
              ),
              IconButton(
                icon: const Icon(LucideIcons.trash2, size: 18, color: Color(0xFFF04438)),
                onPressed: () => _deleteItem(index),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showItemDialog({Map<String, dynamic>? item, int? index}) {
    final bool isEdit = item != null;
    final nameController = TextEditingController(text: isEdit ? item['name'] : "");
    final priceController = TextEditingController(text: isEdit ? item['price'] : "");
    final descController = TextEditingController(text: isEdit ? item['desc'] : "");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(isEdit ? "Edit Item" : "Add New Item"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _dialogField("Item Name", nameController),
              _dialogField("Price (฿)", priceController, isNumber: true),
              _dialogField("Description", descController, maxLines: 3),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Color(0xFF667085))),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (isEdit && index != null) {
                  _menuItems[index] = {
                    ...item,
                    "name": nameController.text,
                    "price": priceController.text,
                    "desc": descController.text,
                  };
                } else {
                  _menuItems.add({
                    "id": DateTime.now().millisecondsSinceEpoch,
                    "name": nameController.text,
                    "price": priceController.text,
                    "desc": descController.text,
                    "cat": "Main",
                  });
                }
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF101828)),
            child: Text(isEdit ? "Update" : "Add Item", style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _dialogField(String label, TextEditingController controller, {bool isNumber = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF2F4F7),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}