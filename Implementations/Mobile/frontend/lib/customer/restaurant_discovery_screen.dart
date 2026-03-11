import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'restaurant_menu_screen.dart';
import 'checkout_screen.dart';
import 'order_history_screen.dart';
import '\\login_screen.dart';

class RestaurantDiscoveryScreen extends StatefulWidget {
  const RestaurantDiscoveryScreen({super.key});

  @override
  State<RestaurantDiscoveryScreen> createState() => _RestaurantDiscoveryScreenState();
}

class _RestaurantDiscoveryScreenState extends State<RestaurantDiscoveryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  int _cartItemsCount = 0;
  String _selectedCuisine = "All";
  bool _filterHighRating = false;
  bool _filterLowPrice = false;

  // Mock Database for the Demo
  final List<Map<String, dynamic>> _allRestaurants = [
    {
      "name": "Bangkok Street Food",
      "tag": "Thai",
      "rating": 4.5,
      "dist": "0.8 km",
      "time": "20-30 min",
      "min": 50,
      "img": "https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=800"
    },
    {
      "name": "Sushi Master",
      "tag": "Japanese",
      "rating": 4.8,
      "dist": "1.2 km",
      "time": "15-25 min",
      "min": 120,
      "img": "https://images.unsplash.com/photo-1579871494447-9811cf80d66c?q=80&w=800"
    },
    {
      "name": "The Burger Joint",
      "tag": "Western",
      "rating": 4.2,
      "dist": "2.5 km",
      "time": "30-45 min",
      "min": 150,
      "img": "https://images.unsplash.com/photo-1571091718767-18b5b1457add?q=80&w=800"
    },
    {
      "name": "Bella Pasta",
      "tag": "Italian",
      "rating": 4.7,
      "dist": "3.1 km",
      "time": "25-35 min",
      "min": 200,
      "img": "https://images.unsplash.com/photo-1551183053-bf91a1d81141?q=80&w=800"
    },
    {
      "name": "Dragon Wok",
      "tag": "Chinese",
      "rating": 4.4,
      "dist": "1.5 km",
      "time": "20-30 min",
      "min": 100,
      "img": "https://images.unsplash.com/photo-1585032226651-759b368d7246?q=80&w=800"
    },
  ];

  // Logic to compute the visible list based on filters
  List<Map<String, dynamic>> get _filteredRestaurants {
    return _allRestaurants.where((res) {
      final matchSearch = res['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
                          res['tag'].toLowerCase().contains(_searchQuery.toLowerCase());
      final matchCuisine = _selectedCuisine == "All" || res['tag'] == _selectedCuisine;
      final matchRating = !_filterHighRating || res['rating'] >= 4.5;
      final matchPrice = !_filterLowPrice || res['min'] <= 100;
      
      return matchSearch && matchCuisine && matchRating && matchPrice;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _updateCartCount(int count) {
    setState(() => _cartItemsCount += count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context, _cartItemsCount),
            _buildCuisineSelector(),
            _buildFilterRow(),
            Expanded(
              child: _filteredRestaurants.isEmpty 
                ? _buildEmptySearchState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: _filteredRestaurants.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            "${_filteredRestaurants.length} restaurants found",
                            style: const TextStyle(color: Color(0xFF667085), fontSize: 13),
                          ),
                        );
                      }
                      final res = _filteredRestaurants[index - 1];
                      return _buildRestaurantCard(context, res);
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, int count) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("🍔 FoodExpress", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderHistoryScreen())),
                    icon: const Icon(LucideIcons.clipboardList, size: 22),
                  ),
                  IconButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckoutScreen())),
                    icon: Badge(
                      isLabelVisible: count > 0,
                      label: Text("$count"),
                      child: const Icon(LucideIcons.shoppingCart, size: 22),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (r) => false),
                    icon: const Icon(LucideIcons.logOut, size: 20, color: Color(0xFFF04438)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: const Icon(LucideIcons.search, size: 18),
              suffixIcon: _searchQuery.isNotEmpty 
                ? IconButton(icon: const Icon(Icons.clear, size: 18), onPressed: () => _searchController.clear()) 
                : null,
              hintText: "Search for food or cuisines...",
              filled: true,
              fillColor: const Color(0xFFF2F4F7),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCuisineSelector() {
    final cuisines = ["All", "Thai", "Japanese", "Western", "Italian", "Chinese"];
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        itemCount: cuisines.length,
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ChoiceChip(
            label: Text(cuisines[i]),
            selected: _selectedCuisine == cuisines[i],
            onSelected: (val) => setState(() => _selectedCuisine = cuisines[i]),
            selectedColor: const Color(0xFFF79009),
            labelStyle: TextStyle(color: _selectedCuisine == cuisines[i] ? Colors.white : Colors.black87, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          _filterBadge("Ratings 4.5+", LucideIcons.star, _filterHighRating, () {
            setState(() => _filterHighRating = !_filterHighRating);
          }),
          const SizedBox(width: 8),
          _filterBadge("Under ฿100", LucideIcons.banknote, _filterLowPrice, () {
            setState(() => _filterLowPrice = !_filterLowPrice);
          }),
        ],
      ),
    );
  }

  Widget _filterBadge(String text, IconData icon, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.orange.shade50 : Colors.white,
          border: Border.all(color: isActive ? Colors.orange : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, size: 12, color: isActive ? Colors.orange : Colors.grey.shade700),
            const SizedBox(width: 4),
            Text(text, style: TextStyle(fontSize: 11, color: isActive ? Colors.orange : Colors.black, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptySearchState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(LucideIcons.searchX, size: 48, color: Color(0xFFD0D5DD)),
          const SizedBox(height: 16),
          const Text("No restaurants found", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Text("Try adjusting your filters or search terms", style: TextStyle(color: Color(0xFF667085))),
          TextButton(onPressed: () => setState(() {
            _searchController.clear();
            _selectedCuisine = "All";
            _filterHighRating = false;
            _filterLowPrice = false;
          }), child: const Text("Clear all filters", style: TextStyle(color: Color(0xFFF79009)))),
        ],
      ),
    );
  }

  Widget _buildRestaurantCard(BuildContext context, Map<String, dynamic> res) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantMenuScreen(restaurantName: res['name'], imgUrl: res['img'], onItemAdded: _updateCartCount))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(res['img'], height: 160, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(res['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8)),
                        child: Text(res['tag'], style: const TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, size: 14, color: Colors.orange.shade700),
                      Text(" ${res['rating']}  •  ${res['dist']}  •  ${res['time']}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text("Min. order ฿${res['min']}", style: const TextStyle(fontSize: 11, color: Color(0xFF667085))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}