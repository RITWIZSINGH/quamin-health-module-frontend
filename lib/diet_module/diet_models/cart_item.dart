class CartItem {
  final String id;
  final String name;
  final String type;
  final double price;
  final String unit;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    this.unit = 'kg',
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;
}