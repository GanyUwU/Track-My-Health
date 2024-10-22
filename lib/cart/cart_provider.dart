import 'package:flutter/material.dart';

import '../models/cart_model.dart';



class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  void addItem(String id, String name, double price) {
    if (_items.containsKey(id)) {
      _items.update(
        id,
            (existingItem) => CartItem(
          id: existingItem.id,
          name: existingItem.name,
          price: existingItem.price,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        id,
            () => CartItem(
          id: id,
          name: name,
          price: price,
        ),
      );
    }
    notifyListeners();
  }
}
