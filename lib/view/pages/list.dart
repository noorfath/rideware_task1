import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rideware_task1/const.dart';
import 'package:rideware_task1/model/loginmodel.dart';
import 'package:rideware_task1/view/pages/almadina.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<int?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('userId');
}

Future<void> saveCustomerId(int customerId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('customerId', customerId);
}

Future<int?> getCustomerId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('customerId');
}

class Customermodel {
  bool isValid;
  String message;
  List<Datum> data;

  Customermodel({
    required this.isValid,
    required this.message,
    required this.data,
  });

  factory Customermodel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Datum> dataList = list.map((i) => Datum.fromJson(i)).toList();
    return Customermodel(
      isValid: json['isValid'],
      message: json['message'],
      data: dataList,
    );
  }
}

class Datum {
  int custId;
  String name;
  int? routeId; // Make routeId nullable

  Datum({
    required this.custId,
    required this.name,
    this.routeId, // Make this field optional
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      custId: json['custId'] ?? 0, // Provide default value if null
      name: json['name'] ?? '', // Provide default value if null
      routeId: json['routeId'], // Handle nullable value
    );
  }
}

class CustomerListPage extends StatefulWidget {
  final int routeId;
  final int userId;

  const CustomerListPage({super.key, required this.routeId, required this.userId, required int custId});

  @override
  _CustomerListPageState createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  List<Datum> _customers = [];

  @override
  void initState() {
    super.initState();
    _fetchCustomers();
  }

  Future<void> _fetchCustomers() async {
    final url = 'https://testapi.wideviewers.com/Customer/GetCustomersByRoute';
    final Map<String, dynamic> reqBody = {
      "routeId": widget.routeId // Use the passed routeId
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(reqBody),
        headers: {'Content-Type': 'application/json', 'Accept': '/'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final customerResponse = Customermodel.fromJson(responseData);
        setState(() {
          _customers = customerResponse.data;
        });
      } else {
        print('Failed to load customers (status code: ${response.statusCode})');
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
          statusBarIconBrightness: Brightness.dark, // Use Brightness.light for white icons
        ),
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
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Icon(
                            Icons.location_pin,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Umm Al Quwain',
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
                        // Search Bar
                        Material(
                          elevation: 7.0,
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                size: 30,
                                color: container1,
                              ),
                              hintText: 'Search Customer',
                              hintStyle: TextStyle(
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontSize: fontsize * 0.035),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 45),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Customer List',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: text1,
                                    fontSize: fontsize * 0.04,
                                    fontFamily: GoogleFonts.poppins().fontFamily),
                              ),
                            ),
                            Text(
                              'New',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Colors.green,
                                  fontSize: fontsize * 0.04,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        // Customer Cards
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _customers.length,
                          itemBuilder: (context, index) {
                            final customer = _customers[index];
                            return Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                leading: Image.asset(
                                  'assets/icons/shop (1).png',
                                  width: 40,
                                  height: 40,
                                ),
                                title: Text(
                                  customer.name,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: fontsize * 0.04,
                                        color: Colors.black),
                                  ),
                                ),
                                subtitle: Text(
                                  'Customer ID: ${customer.custId}',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: fontsize * 0.035,
                                      color: text1,
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  await saveCustomerId(customer.custId);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Almadina(
                                        customer: customer,
                                        userId: widget.userId, custId: customer.custId,
                                      ),
                                    ),
                                  );
                                },
                              ),
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
        ));
  }
}