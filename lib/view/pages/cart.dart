import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../const.dart';

class cart extends StatefulWidget {
  const cart({super.key});

  @override
  State<cart> createState() => _AlmadinaState();
}

class _AlmadinaState extends State<cart> {
  int strawberryCakeQuantity = 5;
  int blackForestQuantity = 8;

  void incrementQuantity(int index) {
    setState(() {
      if (index == 0) {
        strawberryCakeQuantity++;
      } else if (index == 1) {
        blackForestQuantity++;
      }
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (index == 0 && strawberryCakeQuantity > 0) {
        strawberryCakeQuantity--;
      } else if (index == 1 && blackForestQuantity > 0) {
        blackForestQuantity--;
      }
    });
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
                fontSize: fontsize*0.045,
                fontFamily: GoogleFonts.poppins().fontFamily,
                color: Colors.white,
              ),
            ),
            backgroundColor: appbarcolor,
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
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => cart()));
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
        body: SingleChildScrollView(
          child: Container(
            width: width,
            child: Column(
              children: [
                Container(
                  height: height * 0.16,
                  width: width,
                  decoration: BoxDecoration(
                    color: container1,
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
                            padding: const EdgeInsets.only(left:12.0),
                            child: Text(
                              'Items',
                              style: TextStyle(
                                  fontSize: fontsize * 0.04,
                                  fontFamily: GoogleFonts.poppins().fontFamily),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right:12.0),
                            child: Text(
                              'New',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: fontsize * 0.04,
                                  fontFamily: GoogleFonts.poppins().fontFamily),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      buildCartItem(
                        'Strawberry Cake',
                        72,
                        strawberryCakeQuantity,
                        0,
                        incrementQuantity,
                        decrementQuantity,
                      ),
                      buildCartItem(
                        'Black Forest',
                        72,
                        blackForestQuantity,
                        1,
                        incrementQuantity,
                        decrementQuantity,
                      ),
                      SizedBox(height: 10),
                      Card(
                        color: Colors.white,
                        elevation: 4,
                        margin: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 0), // Adjust margin for spacing
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            buildSummaryRow('Total Amount', 72, 0),
                            buildSummaryRow('Tax', 72, 1),
                            buildSummaryRow('Discount', 72, 2),
                            buildSummaryRow('Total', 72, 3),
                            SizedBox(
                              height: 20,
                            )
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
}
