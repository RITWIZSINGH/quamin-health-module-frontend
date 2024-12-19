import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:quamin_health_module/diet_module/diet_models/cart_address.dart';
import '../../../diet_providers/cart_provider.dart';
import '../../../diet_widgets/diet_cart_widgets/quantity_control.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Address? selectedAddress;
  final List<Address> addresses = [
    Address(
      houseNo: '42B',
      street: 'Main Street',
      society: 'Green Valley',
      locality: 'West Zone',
      landmark: 'City Park',
      city: 'Mumbai',
      state: 'Maharashtra',
      pincode: '400001',
      phone: '9876543210',
    ),
    Address(
      houseNo: '15A',
      street: 'Park Road',
      society: 'Blue Heights',
      locality: 'East Zone',
      landmark: 'Central Mall',
      city: 'Mumbai',
      state: 'Maharashtra',
      pincode: '400002',
      phone: '9876543211',
    ),
  ];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _houseNoController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _societyController = TextEditingController();
  final TextEditingController _localityController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (addresses.isNotEmpty) {
      selectedAddress = addresses[0];
    }
  }

  @override
  void dispose() {
    _houseNoController.dispose();
    _streetController.dispose();
    _societyController.dispose();
    _localityController.dispose();
    _landmarkController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pincodeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _showAddAddressDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Address'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildFormField(
                  controller: _houseNoController,
                  label: 'House/Flat No.',
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter house/flat no.' : null,
                ),
                _buildFormField(
                  controller: _streetController,
                  label: 'Street',
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter street' : null,
                ),
                _buildFormField(
                  controller: _societyController,
                  label: 'Society Name',
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter society name' : null,
                ),
                _buildFormField(
                  controller: _localityController,
                  label: 'Locality',
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter locality' : null,
                ),
                _buildFormField(
                  controller: _landmarkController,
                  label: 'Landmark',
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter landmark' : null,
                ),
                _buildFormField(
                  controller: _cityController,
                  label: 'City',
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter city' : null,
                ),
                _buildFormField(
                  controller: _stateController,
                  label: 'State',
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter state' : null,
                ),
                _buildFormField(
                  controller: _pincodeController,
                  label: 'Pincode',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Please enter pincode';
                    if (value!.length != 6) return 'Pincode must be 6 digits';
                    return null;
                  },
                ),
                _buildFormField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Please enter phone number';
                    if (value!.length != 10) return 'Phone must be 10 digits';
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _saveAddress,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff2ed12e),
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _saveAddress() {
    if (_formKey.currentState?.validate() ?? false) {
      final newAddress = Address(
        houseNo: _houseNoController.text,
        street: _streetController.text,
        society: _societyController.text,
        locality: _localityController.text,
        landmark: _landmarkController.text,
        city: _cityController.text,
        state: _stateController.text,
        pincode: _pincodeController.text,
        phone: _phoneController.text,
      );

      setState(() {
        addresses.add(newAddress);
        selectedAddress = newAddress;
      });

      // Clear form
      _houseNoController.clear();
      _streetController.clear();
      _societyController.clear();
      _localityController.clear();
      _landmarkController.clear();
      _cityController.clear();
      _stateController.clear();
      _pincodeController.clear();
      _phoneController.clear();

      Navigator.pop(context);
    }
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        keyboardType: keyboardType,
        validator: validator,
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
            DropdownButtonFormField<Address>(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        address.shortAddress,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Phone: ${address.phone}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedAddress = value;
                });
              },
              selectedItemBuilder: (BuildContext context) {
                return addresses.map((Address address) {
                  return Text(
                    address.shortAddress,
                    overflow: TextOverflow.ellipsis,
                  );
                }).toList();
              },
            ),
            if (selectedAddress != null) ...[
              const SizedBox(height: 8),
              Text(
                selectedAddress!.formattedAddress,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ],
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
