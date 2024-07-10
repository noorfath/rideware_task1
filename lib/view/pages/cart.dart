import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

// Assuming you have a constants file for colors and styles
import '../../const.dart';

class Item {
  final String title;
  final double price; // Keep as double if necessary
  int quantity;

  Item({
    required this.title,
    required this.price,
    required this.quantity,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      title: json['title'],
      price: json['price'].toDouble(), // Convert to double if necessary
      quantity: json['quantity'],
    );
  }
}

class CartModel {
  final double tax;
  final double discount;

  CartModel({required this.tax, required this.discount});
}

class Cart extends StatefulWidget {
  final List<Item> initialItems; // List to hold the items passed from the previous page

  Cart({
    Key? key,
    required this.initialItems,
  }) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Item> items = [];
  CartModel cartModel = CartModel(tax: 5.0, discount: 10.0); // Example values for tax and discount

  @override
  void initState() {
    super.initState();
    items = widget.initialItems; // Initialize items with the passed items
  }

  void placeOrder() async {
    var apiUrl = 'https://testapi.wideviewers.com/Sales/CreateSO'; // Replace with your API endpoint URL

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'items': items.map((item) => {
            'title': item.title,
            'price': item.price,
            'quantity': item.quantity,
          }).toList(),
        }),
      ).timeout(Duration(seconds: 20)); // Increased timeout duration

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        print('Order placed successfully: $jsonData');
        // Show success message or navigate to another screen
      } else {
        print('Failed to place order: ${response.statusCode}');
        showErrorDialog('Failed to place order. Please try again.');
      }
    } catch (e) {
      print('Error placing order: $e');
      showErrorDialog('Error placing order. Please check your internet connection and try again.');
    }
  }

  void showErrorDialog(String message) {
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

  void incrementQuantity(int index) {
    setState(() {
      items[index].quantity++;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (items[index].quantity > 0) {
        items[index].quantity--;
      }
    });
  }

  int getTotalAmount() {
    int total = 0;
    for (var item in items) {
      total += (item.price * item.quantity).toInt(); // Ensure toInt() if price is double
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

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var fontsize = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: AppBar(
            title: Text(
              'Cart',
              style: TextStyle(
                fontSize: fontsize * 0.045,
                fontFamily: GoogleFonts.poppins().fontFamily,
                color: Colors.white,
              ),
            ),
            backgroundColor: appbarcolor, // Replace with your appbar color
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Cart(
                      initialItems: widget.initialItems,
                    ),
                  ));
                },
                icon: Icon(Icons.shopping_cart_rounded),
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: width,
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.16,
                        width: width,
                        decoration: BoxDecoration(
                          color: container1, // Replace with your container color
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 22.0),
                              child: Text(
                                'Al Madeena Grocery',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontsize * 0.045,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 22.0),
                              child: Text(
                                'Al Barsha-Dubai',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontsize * 0.02,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Text(
                                    'Items',
                                    style: TextStyle(
                                      fontSize: fontsize * 0.04,
                                      fontFamily: GoogleFonts.poppins().fontFamily,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Text(
                                    'New',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: fontsize * 0.04,
                                      fontFamily: GoogleFonts.poppins().fontFamily,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            // Display items
                            Column(
                              children: items.map((item) {
                                return buildCartItem(
                                  item.title,
                                  item.price,
                                  item.quantity,
                                  items.indexOf(item),
                                  incrementQuantity,
                                  decrementQuantity,
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Fixed bottom summary card and place order button
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          children: [
                            buildSummaryRow('Total Amount', getTotalAmountAsDouble(), 0),
                            buildSummaryRow('Tax', getTaxAmount(), 1),
                            buildSummaryRow('Discount', getDiscountAmount(), 2),
                            Divider(height: 20, thickness: 1),
                            buildSummaryRow('Payable Amount', getPayableAmount(), 3),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Place Order',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: container1, // Dark red color
                           
                            textStyle: TextStyle(fontSize: fontsize * 0.03),
                            minimumSize: Size(140, 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5), // Add border radius here
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSummaryRow(String title, int amount, int index) {
    return Container(
      color: index % 2 == 0 ? Colors.white : Colors.grey[300],
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: text1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              'AED $amount',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: container1),
            ),
          ),
        ],
      ),
    );
  }

 Widget buildCartItem(
    String title,
    int price,
    int quantity,
    int index,
    void Function(int) incrementQuantity,
    void Function(int) decrementQuantity,
  ) {
    return Container(
      height: 177,
      child: Card(
        color: Colors.white,
        elevation: 2,
        margin: EdgeInsets.symmetric(
            vertical: 2.5, horizontal: 5), // Adjust margin for spacing
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0), // Adjust padding inside the card
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:14.0),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 14, // Reduced font size
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:14.0),
                        child: Text(
                          'AED $price',
                          style: TextStyle(
                              fontSize: 12, // Reduced font size
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              color: container1),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:8.0),
                    child: Row(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.keyboard_arrow_up_rounded),
                              onPressed: () => incrementQuantity(index),
                              iconSize: 20, // Reduced icon size
                              padding: EdgeInsets.all(0),
                              constraints: BoxConstraints(),
                            ),
                            Text(
                              quantity.toString().padLeft(2, '0'),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.keyboard_arrow_down_rounded),
                              onPressed: () => decrementQuantity(index),
                              iconSize: 20, // Reduced icon size
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                        padding: const EdgeInsets.only(left:8.0),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Remove',
                        style: TextStyle(
                          color: container1,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8), // Reduced padding
                        minimumSize: Size(10, 20), // Reduced minimum size
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Total Price ',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: appbarcolor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right:10.0),
                        child: Text(
                          ' AED ${price * quantity}',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            color: container1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSummaryRow(String title, double amount, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          Text(
            'AED ${amount.toStringAsFixed(2)}', // Adjust as necessary for int or double
            style: TextStyle(
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}