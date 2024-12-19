import 'package:flutter/foundation.dart';
import '../diet_models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};
  
  int get itemCount => _items.length;
  
  double get totalAmount {
    return _items.values.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  void addItem(String id, String name, String type, double price) {
    if (_items.containsKey(id)) {
      _items.update(
        id,
        (existingItem) => CartItem(
          id: existingItem.id,
          name: existingItem.name,
          type: existingItem.type,
          price: existingItem.price,
          unit: existingItem.unit,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        id,
        () => CartItem(
          id: id,
          name: name,
          type: type,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void updateQuantity(String id, int quantity) {
    if (_items.containsKey(id)) {
      if (quantity <= 0) {
        removeItem(id);
      } else {
        _items.update(
          id,
          (existingItem) => CartItem(
            id: existingItem.id,
            name: existingItem.name,
            type: existingItem.type,
            price: existingItem.price,
            unit: existingItem.unit,
            quantity: quantity,
          ),
        );
      }
      notifyListeners();
    }
  }

  void updateUnit(String id, String unit) {
    if (_items.containsKey(id)) {
      _items.update(
        id,
        (existingItem) => CartItem(
          id: existingItem.id,
          name: existingItem.name,
          type: existingItem.type,
          price: existingItem.price,
          unit: unit,
          quantity: existingItem.quantity,
        ),
      );
      notifyListeners();
    }
  }
}