import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../../../diet_providers/cart_provider.dart';
import '../../../diet_widgets/diet_cart_widgets/quantity_control.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? selectedAddress;
  final List<String> addresses = [
    '123 Main St, Apartment 4B, City - 12345',
    '456 Park Avenue, House 7, Town - 67890',
  ];

  @override
  void initState() {
    super.initState();
    if (addresses.isNotEmpty) {
      selectedAddress = addresses[0];
    }
  }

  void _showAddAddressDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Address'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Full Address',
                hintText: 'Enter your complete address',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Implement address saving logic
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2ed12e),
                  ),
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          child: Consumer<CartProvider>(
            builder: (context, cart, child) {
              if (cart.items.isEmpty) {
                return Column(
                  children: [
                    _buildBackButton(),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Your cart is empty',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                );
              }

              return Column(
                children: [
                  _buildBackButton(),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        _buildDeliveryAddressSection(),
                        const SizedBox(height: 16),
                        _buildCartItemsList(cart),
                      ],
                    ),
                  ),
                  _buildCheckoutSection(cart),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildDeliveryAddressSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Delivery Address',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: _showAddAddressDialog,
                  icon: const Icon(
                    Icons.add,
                    color: Color(0xff2ed12e),
                  ),
                  label: const Text(
                    'Add New',
                    style: TextStyle(
                      color: Color(0xff2ed12e),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              items: addresses.map((address) {
                return DropdownMenuItem(
                  value: address,
                  child: Text(
                    address,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedAddress = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItemsList(CartProvider cart) {
    return Column(
      children: cart.items.values.map((item) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.type,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Rs. ${(item.price * item.quantity).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff2ed12e),
                        ),
                      ),
                      Text(
                        '${item.unit} • Rs. ${item.price} each',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                QuantityControl(
                  id: item.id,
                  name: item.name,
                  type: item.type,
                  price: item.price,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCheckoutSection(CartProvider cart) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Items Total:',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  'Rs. ${cart.totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Delivery Fee:',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  'Rs. 40.00',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Amount:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Rs. ${(cart.totalAmount + 40).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2ed12e),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Implement checkout logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2ed12e),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Proceed to Checkout',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
