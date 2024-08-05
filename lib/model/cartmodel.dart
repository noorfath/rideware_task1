import 'package:flutter/material.dart';

class Item {
  final String title;
  final double price;
  final int quantity;

  Item({
    required this.title,
    required this.price,
    required this.quantity,
  });
}

class CartModel extends ChangeNotifier {
  final List<Item> _items = [];
 final double tax;
 final double discount;
  List<Item> get items => _items;
   
   CartModel({required this.tax, required this.discount});
   
  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
