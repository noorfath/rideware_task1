import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rideware_task1/const.dart';
import 'package:rideware_task1/view/pages/salesreturn.dart';

class ReturnSalesPage extends StatefulWidget {
  final int userId;
  final int customerId;

  ReturnSalesPage({Key? key, required this.userId, required this.customerId}) : super(key: key);

  @override
  ReturnSalesPageState createState() => ReturnSalesPageState();
}

class ReturnSalesPageState extends State<ReturnSalesPage> {
  List<Map<String, dynamic>> orders = [];

  @override
  void initState() {
    super.initState();
    _fetchSalesOrders();
  }

  Future<void> _fetchSalesOrders() async {
    final url = 'http://testapi.wideviewers.com/Sales/GetAllSOUser';
    final Map<String, dynamic> requestBody = {
      'userId': widget.userId,
      'customerId': widget.customerId,
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      // Check for redirect
      if (response.statusCode == 307) {
        final newUrl = response.headers['location'];
        if (newUrl != null) {
          response = await http.post(
            Uri.parse(newUrl),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(requestBody),
          );
        }
      }

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse['isValid']) {
          final List<dynamic> data = jsonResponse['data'];
          setState(() {
            orders = data.map((order) => {
              "soId": order["soId"],
              "date": order["date"],
              "total": order["total"],
              "noOfItems": order["noItems"],
              "time": order["time"]
            }).toList();
          });
        } else {
          print('Invalid response: ${jsonResponse['message']}');
        }
      } else {
        print('Failed to load sales orders (status code: ${response.statusCode})');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
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
                  height: height * 0.20,
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 28.0),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                    'assets/images/profile man.png'),
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Customer name',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: fontsize * 0.05,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, top: 20.0, right: 28.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  hintText: 'Search Orders',
                                  hintStyle: TextStyle(
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    fontSize: fontsize * 0.03,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.search_outlined,
                                    color: appbarcolor,
                                    size: 30,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: buildCustomerListView(context, fontsize),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCustomerListView(BuildContext context, double fontsize) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final time = (order["date"]?.contains('T') ?? false)
            ? order["date"].split('T')[1]
            : 'No time'; // Extract time or default value

        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            contentPadding: EdgeInsets.all(10),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'OId: ${order["soId"]}',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: fontsize * 0.04,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      'No of items: ${order["noOfItems"]}',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: fontsize * 0.04,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date: ${order["date"]?.split('T')[0]}',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: fontsize * 0.035,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      'Total: AED${order["total"]}',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: fontsize * 0.035,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Time: $time',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: fontsize * 0.035,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SalesReturn(soId: order["soId"]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
