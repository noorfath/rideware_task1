import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rideware_task1/const.dart';
import 'package:rideware_task1/controller/cartprovider.dart';

class Cart extends StatefulWidget {
  final List<Item> initialItems;

  Cart({required this.initialItems});

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Future<void>? _initializeFuture;

  @override
  void initState() {
    super.initState();
    _initializeFuture = Future.microtask(() {
      if (mounted) {
        Provider.of<CartProvider>(context, listen: false)
            .setInitialItems(widget.initialItems);
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
                fontSize: fontsize * 0.045,
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        Cart(initialItems: widget.initialItems),
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
        body: FutureBuilder<void>(
          future: _initializeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
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
                                    padding:
                                        const EdgeInsets.only(left: 22.0),
                                    child: Text(
                                      'Al Madeena Grocery',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: fontsize * 0.045,
                                          fontFamily: GoogleFonts.poppins()
                                              .fontFamily,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 22.0),
                                    child: Text(
                                      'Al Barsha-Dubai',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: fontsize * 0.02,
                                          fontFamily: GoogleFonts.poppins()
                                              .fontFamily,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Text(
                                          'Items',
                                          style: TextStyle(
                                            fontSize: fontsize * 0.04,
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12.0),
                                        child: Text(
                                          'New',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: fontsize * 0.04,
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Consumer<CartProvider>(
                                    builder: (context, cartProvider, child) {
                                      return Column(
                                        children: cartProvider.items
                                            .map((item) {
                                          return buildCartItem(
                                            item.itemname,
                                            item.price,
                                            item.quantity,
                                            cartProvider.items.indexOf(item),
                                            cartProvider.incrementQuantity,
                                            cartProvider.decrementQuantity,
                                            fontsize,
                                            cartProvider.removeItem,
                                          );
                                        }).toList(),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Consumer<CartProvider>(
                            builder: (context, cartProvider, child) {
                              return Card(
                                color: Colors.white,
                                elevation: 4,
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      buildSummaryRow('Tax:',
                                          cartProvider.getTaxAmount(), fontsize),
                                      buildSummaryRow(
                                          'Discount:',
                                          -cartProvider.getDiscountAmount(),
                                          fontsize),
                                      Divider(
                                          color: Colors.grey, thickness: 1.0),
                                      buildSummaryRow(
                                          'Total Payable:',
                                          cartProvider.getPayableAmount(),
                                          fontsize,
                                          bold: true),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Consumer<CartProvider>(
                            builder: (context, cartProvider, child) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: container1,
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () => _showBottomSheet(context),
                                child: Text(
                                  'Place Order',
                                  style: TextStyle(
                                    fontSize: fontsize * 0.04,
                                    fontFamily: GoogleFonts.poppins()
                                        .fontFamily,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget buildCartItem(
      String title,
      double price,
      int quantity,
      int index,
      Function increment,
      Function decrement,
      double fontsize,
      Function removeItem) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: fontsize * 0.04,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
              Text(
                'Price: \$${price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: fontsize * 0.035,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () => decrement(index),
              ),
              Text(
                '$quantity',
                style: TextStyle(
                  fontSize: fontsize * 0.04,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => increment(index),
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => removeItem(index),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSummaryRow(String label, double amount, double fontsize,
      {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontsize * 0.035,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: fontsize * 0.035,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    TextEditingController discountController = TextEditingController();
    TextEditingController remarksController = TextEditingController();
    bool isVat = false;
    bool isVatExclusive = false;
    bool isVatInclusive = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: discountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Discount',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: remarksController,
                  decoration: InputDecoration(
                    labelText: 'Remarks',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Apply VAT:'),
                    Switch(
                      value: isVat,
                      onChanged: (value) {
                        setState(() {
                          isVat = value;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('VAT Exclusive:'),
                    Switch(
                      value: isVatExclusive,
                      onChanged: (value) {
                        setState(() {
                          isVatExclusive = value;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('VAT Inclusive:'),
                    Switch(
                      value: isVatInclusive,
                      onChanged: (value) {
                        setState(() {
                          isVatInclusive = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: container1,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    cartProvider.placeOrder(
                          cartProvider.items as BuildContext,
                      discount: double.tryParse(discountController.text) ?? 0.0,
                      remarks: remarksController.text,
                      isVat: isVat,
                      isVatExclusive: isVatExclusive,
                      isVatInclusive: isVatInclusive,
                    );
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
