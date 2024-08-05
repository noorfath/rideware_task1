import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rideware_task1/const.dart';
import 'package:rideware_task1/view/pages/orderdetail.dart';
import 'package:rideware_task1/view/pages/salesdetailcmplt.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: SalesHistory(userId: 1, customerId: 1),
//   ));
// }

class SalesHistory extends StatefulWidget {
  final int userId;
  final int customerId;

  const SalesHistory({Key? key, required this.userId, required this.customerId}) : super(key: key);

  @override
  _SalesHistoryState createState() => _SalesHistoryState();
}

class _SalesHistoryState extends State<SalesHistory> {
  DateTime? selectedDate;
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
              "payStatus": order["payStatus"],
              "isDelivered": order["isDelivered"]
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
List<Map<String, dynamic>> _filterOrders(String filter) {
    DateTime now = DateTime.now();
    if (filter == 'All') {
      return orders;
    } else if (filter == 'This Week') {
      DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      return orders.where((order) {
        DateTime orderDate = DateFormat('yyyy-MM-dd').parse(order['date']);
        return orderDate.isAfter(startOfWeek) && orderDate.isBefore(now.add(Duration(days: 1)));
      }).toList();
    } else if (filter == 'This Month') {
      DateTime startOfMonth = DateTime(now.year, now.month, 1);
      return orders.where((order) {
        DateTime orderDate = DateFormat('yyyy-MM-dd').parse(order['date']);
        return orderDate.isAfter(startOfMonth) && orderDate.isBefore(now.add(Duration(days: 1)));
      }).toList();
    } else {
      return orders;
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
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(45.0),
            child: AppBar(
              elevation: 0,
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
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.more_vert_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              ],
              backgroundColor: appbarcolor,
            ),
          ),
          body: SingleChildScrollView(
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
                          'Customer name',
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
                    height: height * 0.80,
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
                        // Date Picker and Text Field in a Row
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 7.0,
                                child: TextField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.calendar_today,
                                      size: 25,
                                      color: container1,
                                    ),
                                    hintText: selectedDate != null
                                        ? "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}"
                                        : 'Select Date',
                                    hintStyle: TextStyle(
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                        fontSize: fontsize * 0.035),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 15.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: container1, // header background color
                                              onPrimary: Colors.white, // header text color
                                              onSurface: text1, // body text color
                                            ),
                                            dialogBackgroundColor: Colors.white, // background color of the picker
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (pickedDate != null) {
                                      setState(() {
                                        selectedDate = pickedDate;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 7.0,
                                child: TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.format_list_numbered,
                                      size: 25,
                                      color: container1,
                                    ),
                                    hintText: 'Order No',
                                    hintStyle: TextStyle(
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                        fontSize: fontsize * 0.035),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      // borderSide: BorderSide.none,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 15.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      // borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 45),
                        // Tab Bar
                        TabBar(
                          labelColor: container1,
                          unselectedLabelColor: text1,
                          indicatorColor: container1,
                          tabs: [
                            Tab(text: 'All'),
                            Tab(text: 'This Week'),
                            Tab(text: 'This Month'),
                          ],
                        ),
                        SizedBox(height: 15),
                        // Tab Bar View
                        Expanded(
                          child: TabBarView(
                            children: [
                              buildCustomerListView(context, fontsize, 'All'),
                              buildCustomerListView(context, fontsize, 'This Week'),
                              buildCustomerListView(context, fontsize, 'This Month'),
                            ],
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
      ),
    );
  }
Widget buildCustomerListView(BuildContext context, double fontsize, String filter) {
    List<Map<String, dynamic>> filteredOrders = _filterOrders(filter);
    return ListView.builder(
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        final soId = order["soId"];
        String status = order["isDelivered"] ? "Delivered" : "Not Delivered";
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
                      '$status',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: fontsize * 0.04,
                          color: status == "Delivered"
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      ' ${order["date"]}',
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
                      'Total: ${order["total"]}',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: fontsize * 0.035,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      'Payment Status: ${order["payStatus"]}',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: fontsize * 0.035,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          // Add your print functionality here
                        },
                        icon: Icon(Icons.print, color: appbarcolor),
                        label: Text(
                          'Print',
                          style: TextStyle(color: appbarcolor),
                        ),
                      ),
                      SizedBox(width: 10),
                      TextButton.icon(
                        onPressed: () {
                          // Add your share functionality here
                        },
                        icon: Icon(Icons.share, color: appbarcolor),
                        label: Text(
                          'Share',
                          style: TextStyle(color: appbarcolor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            onTap: () {
              if (status == 'Delivered') {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => salescmplt(soId: soId,)),
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>  OrderDetail(soId: soId,)),
                );
              }
            },
          ),
        );
      },
    );
  }
}