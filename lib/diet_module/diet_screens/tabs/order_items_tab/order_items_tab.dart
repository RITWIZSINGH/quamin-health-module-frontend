import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../../../diet_providers/cart_provider.dart';
import '../../../diet_widgets/diet_cart_widgets/item_details_sheet.dart';
import '../../../diet_widgets/diet_cart_widgets/quantity_control.dart';

class OrderItemsTab extends StatefulWidget {
  const OrderItemsTab({super.key});

  @override
  State<OrderItemsTab> createState() => _OrderItemsTabState();
}

class _OrderItemsTabState extends State<OrderItemsTab> {
  final List<String> categories = ["Vegetables", "Fruits", "Bread", "Dairy"];
  final Map<String, List<Map<String, String>>> items = {
    "Vegetables": [
      {"name": "Potato", "type": "Organic", "price": "Rs. 30"},
      {"name": "Onion", "type": "Fresh & Organic", "price": "Rs. 25"},
      {"name": "Coriander", "type": "Organic", "price": "Rs. 15"},
    ],
    "Fruits": [
      {"name": "Apple", "type": "Fresh & Organic", "price": "Rs. 45"},
      {"name": "Banana", "type": "Organic", "price": "Rs. 35"},
      {"name": "Grapes", "type": "Organic", "price": "Rs. 60"},
    ],
    "Bread": [
      {"name": "Sourdough", "type": "Wholegrain", "price": "Rs. 50"},
      {"name": "White", "type": "Classic", "price": "Rs. 40"},
      {"name": "Multigrain", "type": "Healthy Choice", "price": "Rs. 55"},
    ],
    "Dairy": [
      {"name": "Milk", "type": "Low Fat", "price": "Rs. 45"},
      {"name": "Cheese", "type": "Organic", "price": "Rs. 80"},
      {"name": "Yogurt", "type": "Greek Style", "price": "Rs. 35"},
    ],
  };

  int selectedIndex = 0;
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();

  List<Map<String, String>> getFilteredItems() {
    final categoryItems = items[categories[selectedIndex]]!;
    if (searchQuery.isEmpty) return categoryItems;

    return categoryItems.where((item) {
      return item["name"]!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["type"]!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffe1f1cf), Color(0xffa8dfc9)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(sw, sh),
                _buildRecommendedSection(sw, sh),
                _buildCategoriesScroll(sw, sh),
                _buildItemsGrid(sw, sh),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(double sw, double sh) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Padding(
          padding: EdgeInsets.all(sw * 0.04),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Search Products or store",
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(sw * 0.08),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: sw * 0.04),
              Stack(
                children: [
                  const Icon(Icons.shopping_cart, color: Colors.black),
                  if (cart.itemCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cart.itemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRecommendedSection(double sw, double sh) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sh * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
            child: Text(
              "Recommended",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: sw * 0.045,
              ),
            ),
          ),
          SizedBox(height: sh * 0.01),
          SizedBox(
            height: sh * 0.2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: sw * 0.04),
                  child: _buildRecommendedCard(sw, sh),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedCard(double sw, double sh) {
    return Container(
      width: sw * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sw * 0.04),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: sw * 0.01,
            spreadRadius: sw * 0.005,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LucideIcons.image, size: sw * 0.12, color: Colors.grey),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sw * 0.07),
            child: Divider(thickness: sw * 0.002),
          ),
          SizedBox(height: sh * 0.002),
          Text(
            "Fresh Lemon",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: sw * 0.035,
            ),
          ),
          SizedBox(height: sh * 0.005),
          Text(
            "Organic",
            style: TextStyle(
              fontSize: sw * 0.03,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: sh * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Rs. 40",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: sw * 0.035,
                ),
              ),
              Icon(
                LucideIcons.plusCircle,
                color: const Color.fromARGB(255, 38, 101, 210),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesScroll(double sw, double sh) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Shop by category",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: sw * 0.045,
            ),
          ),
          SizedBox(height: sh * 0.02),
          SizedBox(
            height: sh * 0.06,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      searchController.clear();
                      searchQuery = '';
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: sw * 0.03),
                    padding: EdgeInsets.symmetric(
                      horizontal: sw * 0.04,
                      vertical: sh * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: selectedIndex == index
                          ? const Color(0xff2ed12e)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(sw * 0.05),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: selectedIndex == index
                              ? Colors.white
                              : Colors.blueGrey.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: sw * 0.04,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsGrid(double sw, double sh) {
    final filteredItems = getFilteredItems();
    
    return Padding(
      padding: EdgeInsets.all(sw * 0.04),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: sw * 0.03,
          mainAxisSpacing: sh * 0.02,
          childAspectRatio: 3 / 4,
        ),
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          return _buildItemCard(
              item["name"]!, item["type"]!, item["price"]!, sw, sh);
        },
      ),
    );
  }

  Widget _buildItemCard(String name, String type, String price, double sw, double sh) {
    final priceValue = double.parse(price.replaceAll('Rs. ', ''));
    final id = '$name-$type'; // Create a unique ID for the item

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => ItemDetailsSheet(
            id: id,
            name: name,
            type: type,
            price: priceValue,
            description: 'Fresh and high-quality $name. $type quality product.',
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(sw * 0.04),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: sw * 0.02,
              spreadRadius: sw * 0.01,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.image,
              size: sw * 0.2,
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sw * 0.1),
              child: Divider(thickness: sw * 0.002),
            ),
            SizedBox(height: sh * 0.002),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: sw * 0.045,
              ),
            ),
            SizedBox(height: sh * 0.005),
            Text(
              type,
              style: TextStyle(
                fontSize: sw * 0.035,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: sh * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  price,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: sw * 0.04,
                  ),
                ),
                QuantityControl(
                  id: id,
                  name: name,
                  type: type,
                  price: priceValue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}