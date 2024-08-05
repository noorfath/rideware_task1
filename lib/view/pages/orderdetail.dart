import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rideware_task1/const.dart';

class OrderDetail extends StatefulWidget {
  final int soId;

  const OrderDetail({super.key, required this.soId});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  Data? orderData;

  @override
  void initState() {
    super.initState();
    fetchOrderDetails();
  }

  Future<void> fetchOrderDetails() async {
    final url = Uri.parse('https://testapi.wideviewers.com/Sales/GetSOById');
    final body = jsonEncode({"id": widget.soId});
    print('Sending request with soId: ${widget.soId}');

    final response = await http.post(
      url,
      body: body,
      headers: {"Content-Type": "application/json"},
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        if (data.containsKey('data') && data['data'] != null) {
          setState(() {
            orderData = Customermodel.fromJson(data).data;
          });
        } else {
          print('Data key is missing or null in response');
        }
      } catch (e) {
        print('Error parsing response: $e');
      }
    } else {
      print('Failed to load order details');
    }
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
            backgroundColor: container1,
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
        body: orderData == null
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      color: container1,
                      child: Column(
                        children: [
                          Container(
                            height: height * 0.18,
                            color: container1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        AssetImage('assets/images/profile man.png'),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  orderData!.customerName,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontsize * 0.05,
                                        fontFamily: GoogleFonts.poppins().fontFamily),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Old: ${widget.soId}',
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: fontsize * 0.04),
                                              ),
                                            ),
                                            Text(
                                              'Date: ${orderData!.date}',
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: fontsize * 0.04),
                                              ),
                                            ),
                                            Text(
                                              'No: Items: ${orderData!.noItems}',
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: fontsize * 0.04),
                                              ),
                                            ),
                                            Text(
                                              'Status: Created',
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: fontsize * 0.04),
                                              ),
                                            ),
                                            Text(
                                              'Pay Status: ${orderData!.payStatus}',
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: fontsize * 0.04),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'SubTotal: ${orderData!.total}',
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: fontsize * 0.04),
                                              ),
                                            ),
                                            Text(
                                              'Discount: ${orderData!.discount}',
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: fontsize * 0.04),
                                              ),
                                            ),
                                            Text(
                                              'After Disc: ${orderData!.totalafterDisc}',
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: fontsize * 0.04),
                                              ),
                                            ),
                                            Text(
                                              'Vat: ${orderData!.vat}',
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: fontsize * 0.04),
                                              ),
                                            ),
                                            Text(
                                              'Total: ${orderData!.totalafterVat}',
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: fontsize * 0.04),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12.0),
                                      child: Text(
                                        'Items List',
                                        style: TextStyle(
                                            fontSize: fontsize * 0.04,
                                            fontFamily: GoogleFonts.poppins().fontFamily),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 12.0),
                                      child: TextButton(
                                        onPressed: () {
                                          // Implement your edit order functionality here
                                        },
                                        child: Text(
                                          'Edit Order',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: fontsize * 0.04,
                                              fontFamily: GoogleFonts.poppins().fontFamily),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                ...orderData!.detail.map((detail) =>
                                  buildSalesItem(
                                    'Item: ${detail.itemName}', 
                                    'Category: ${detail.categoryName}', 
                                    'Unit Price: ${detail.price}', 
                                    'Qty: ${detail.quantity}', 
                                    'Description: ${detail.descriiption}', 
                                    'Total: ${detail.total}'
                                  )
                                ).toList(),
                                SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          orderData!.isConfirmed ? 'Mark Delivered' : 'Mark Confirmed',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: container1,
                          textStyle: TextStyle(fontSize: fontsize * 0.035),
                          fixedSize: Size(width * 0.80, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

 Widget buildSalesItem(String item, String category, String unitPrice, String qty, String description, String total) {
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  var fontsize = MediaQuery.of(context).size.width;

  return Container(
    child: Card(
      color: Colors.white,
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              item,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: fontsize * 0.04),
              ),
            ),
          ),
          Divider(color: Colors.black, thickness: 0.2),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              category,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: fontsize * 0.035),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              unitPrice,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: fontsize * 0.035),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              qty,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: fontsize * 0.035),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              description,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: fontsize * 0.035),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              total,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: fontsize * 0.035),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}

// Data model classes
class Customermodel {
  Data data;

  Customermodel({required this.data});

  factory Customermodel.fromJson(Map<String, dynamic> json) {
    return Customermodel(
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  String customerName;
  int noItems;
  String date;
  String payStatus;
  double total;
  double discount;
  double totalafterDisc;
  double vat;
  double totalafterVat;
  bool isConfirmed; // Added isConfirmed field
  List<Detail> detail;

  Data({
    required this.customerName,
    required this.noItems,
    required this.date,
    required this.payStatus,
    required this.total,
    required this.discount,
    required this.totalafterDisc,
    required this.vat,
    required this.totalafterVat,
    required this.isConfirmed, // Added isConfirmed field
    required this.detail,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var detailList = json['detail'] as List;
    List<Detail> details = detailList.map((i) => Detail.fromJson(i)).toList();

    // Helper function to safely parse numbers
    double parseDouble(dynamic value) {
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) {
        try {
          return double.parse(value);
        } catch (e) {
          print('Error parsing double from string: $value');
          return 0.0; // Default value in case of error
        }
      }
      return 0.0; // Default value if none of the above
    }

    return Data(
      customerName: json['customerName'] ?? '',
      noItems: json['noItems'] is int ? json['noItems'] : int.tryParse(json['noItems']?.toString() ?? '0') ?? 0,
      date: json['date'] ?? '',
      payStatus: json['payStatus'] ?? '',
      total: parseDouble(json['total']),
      discount: parseDouble(json['discount']),
      totalafterDisc: parseDouble(json['totalafterDisc']),
      vat: parseDouble(json['vat']),
      totalafterVat: parseDouble(json['totalafterVat']),
      isConfirmed: json['isConfirmed'] ?? false, // Added isConfirmed field
      detail: details,
    );
  }
}

class Detail {
  String itemName;
  String categoryName;
  double price;
  int quantity;
  String descriiption;
  double total;

  Detail({
    required this.itemName,
    required this.categoryName,
    required this.price,
    required this.quantity,
    required this.descriiption,
    required this.total,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    // Helper function to safely parse numbers
    double parseDouble(dynamic value) {
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) {
        try {
          return double.parse(value);
        } catch (e) {
          print('Error parsing double from string: $value');
          return 0.0; // Default value in case of error
        }
      }
      return 0.0; // Default value if none of the above
    }

    return Detail(
      itemName: json['itemName'] ?? '',
      categoryName: json['categoryName'] ?? '',
      price: parseDouble(json['price']),
      quantity: json['quantity'] is int ? json['quantity'] : int.tryParse(json['quantity']?.toString() ?? '0') ?? 0,
      descriiption: json['descriiption'] ?? '',
      total: parseDouble(json['total']),
    );
  }
}
