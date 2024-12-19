import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quamin_health_module/diet_module/diet_providers/cart_provider.dart';
// import '../providers/cart_provider.dart';

class QuantityControl extends StatelessWidget {
  final String id;
  final String name;
  final String type;
  final double price;

  const QuantityControl({
    Key? key,
    required this.id,
    required this.name,
    required this.type,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        final item = cart.items[id];

        if (item == null) {
          return IconButton(
            icon: const Icon(
              Icons.add_circle,
              color: Color.fromARGB(255, 38, 101, 210),
            ),
            onPressed: () => cart.addItem(id, name, type, price),
          );
        }

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () => cart.updateQuantity(id, item.quantity - 1),
            ),
            Text(
              item.quantity.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () => cart.updateQuantity(id, item.quantity + 1),
            ),
          ],
        );
      },
    );
  }
}