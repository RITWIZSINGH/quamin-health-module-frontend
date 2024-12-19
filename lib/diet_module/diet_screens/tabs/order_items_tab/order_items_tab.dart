import 'package:flutter/material.dart';

class OrderItemsTab extends StatelessWidget {
  const OrderItemsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Background gradient starts here
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffe1f1cf), Color(0xffa8dfc9)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar and Top Area
              _buildAppBar(),
        
              // Recommended Section
              _buildRecommendedSection(),
        
              // Shop by Category Section
              Expanded(
                child: _buildCategorySection(),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildCategorySection() {
  final categories = ["Vegetables", "Fruits", "Bread", "Dairy"];

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Shop by category",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return _buildCategoryCard(categories[index]);
            },
          ),
        ),
      ],
    ),
  );
}

Widget _buildCategoryCard(String category) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          spreadRadius: 2,
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.image, size: 50, color: Colors.grey), // Placeholder image
        const SizedBox(height: 10),
        Text(
          category,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    ),
  );
}

  Widget _buildRecommendedSection() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Recommended",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 150, // Adjust height for the horizontal list
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: _buildRecommendedCard(),
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget _buildRecommendedCard() {
  return Container(
    width: 120,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          spreadRadius: 2,
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.image, size: 50, color: Colors.grey), // Placeholder image
        const SizedBox(height: 10),
        Text(
          "Fresh Lemon",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 5),
        Text("Organic", style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 10),
        Text(
          "Rs. 40",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

  Widget _buildAppBar() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "Search Products or store",
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Icon(Icons.shopping_cart, color: Colors.black),
      ],
    ),
  );
}

}
