import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quamin_health_module/diet_module/diet_providers/cart_provider.dart';
// import '../providers/cart_provider.dart';

class ItemDetailsSheet extends StatelessWidget {
  final String id;
  final String name;
  final String type;
  final double price;
  final String description;

  const ItemDetailsSheet({
    Key? key,
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final item = cartProvider.items[id];
    final units = ['kg', 'g', 'piece'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            type,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Rs. ${price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              if (item != null) ...[
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => cartProvider.updateQuantity(id, item.quantity - 1),
                ),
                Text(
                  item.quantity.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => cartProvider.updateQuantity(id, item.quantity + 1),
                ),
              ] else
                ElevatedButton(
                  onPressed: () => cartProvider.addItem(id, name, type, price),
                  child: const Text('Add to Cart'),
                ),
            ],
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: item?.unit ?? units[0],
            decoration: const InputDecoration(
              labelText: 'Unit',
              border: OutlineInputBorder(),
            ),
            items: units.map((unit) {
              return DropdownMenuItem(
                value: unit,
                child: Text(unit),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                cartProvider.updateUnit(id, value);
              }
            },
          ),
        ],
      ),
    );
  }
}