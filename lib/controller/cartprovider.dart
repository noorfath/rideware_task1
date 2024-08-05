import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rideware_task1/model/cartmodel.dart';

class CartProvider with ChangeNotifier {
  List<Item> items = [];
  CartModel cartModel = CartModel(tax: 5.0, discount: 10.0);

  void addItem(Item item, int quantity) {
    items.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    items.removeAt(index);
    notifyListeners();
  }

  void incrementQuantity(int index) {
    items[index].quantity++;
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (items[index].quantity > 0) {
      items[index].quantity--;
      notifyListeners();
    }
  }

  void setInitialItems(List<Item> initialItems) {
    items = initialItems;
    notifyListeners();
  }

  int getTotalAmount() {
    int total = 0;
    for (var item in items) {
      total += (item.price * item.quantity).toInt();
    }
    return total;
  }

  double getTotalAmountAsDouble() {
    return getTotalAmount().toDouble();
  }

  double getTaxAmount() {
    return (getTotalAmount() * cartModel.tax) / 100;
  }

  double getDiscountAmount() {
    return (getTotalAmount() * cartModel.discount) / 100;
  }

  double getPayableAmount() {
    return getTotalAmountAsDouble() + getTaxAmount() - getDiscountAmount();
  }

  void placeOrder(BuildContext context, {
    required bool isVat,
    required bool isVatExclusive,
    required bool isVatInclusive,
    required String remarks,
   required double discount,
  }) async {
    var apiUrl = 'https://testapi.wideviewers.com/Sales/CreateSO';

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'soId': 0,
          'cretedBy': 0, // replace with actual user id
          'customerId': 0, // replace with actual customer id
          'items': items.map((item) => {
                // 'solId': item.solId,
                'itemId': item.itemId,
                'itemname': item.itemname,
                'categoryId': item.categoryId,
                'quantity': item.quantity,
                'price': item.price,
                'total': item.price * item.quantity,
                'remarks': item.remarks,
                'isDeleted': item.isDeleted,
              }).toList(),
          'total': getTotalAmount(),
          'discount': getDiscountAmount(),
          'totalAfterDiscount': getTotalAmount() - getDiscountAmount(),
          'isVat': isVat,
          'isVatExclusive': isVatExclusive,
          'isVatInclusive': isVatInclusive,
          'remarks': remarks,
        }),
      ).timeout(Duration(seconds: 20));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        print('Order placed successfully: $jsonData');
      } else {
        print('Failed to place order: ${response.statusCode}');
        showErrorDialog(context, 'Failed to place order. Please try again.');
      }
    } catch (e) {
      print('Error placing order: $e');
      showErrorDialog(context, 'Error placing order. Please check your internet connection and try again.');
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

// lib/model/item.dart

class Item {
  // final int solId;
  final int itemId;
  final String itemname;
  final int categoryId;
  final double price;
  int quantity;
  double total;
  String remarks;
  bool isDeleted;

  Item({
    // required this.solId,
    required this.itemId,
    required this.itemname,
    required this.categoryId,
    required this.price,
    required this.quantity,
    double? total,
    this.remarks = '',
    this.isDeleted = false,
  }) : total = total ?? price * quantity;
}
