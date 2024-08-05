import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:rideware_task1/const.dart'; // Assuming this contains your constants
import 'package:rideware_task1/controller/modelclass.dart';
import 'package:rideware_task1/model/routemodel2.dart';
import 'package:rideware_task1/view/pages/list.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Adjust import as per your project

Future<int?> getCustomerId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('customerId');
}

class Homepage1 extends StatefulWidget {
  final String username;
  final int userId;

  Homepage1({Key? key, required this.username, required this.userId}) : super(key: key);

  @override
  State<Homepage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<Homepage1> {
  late int custId;
  String _selectedRoute = '';
  String _selectedRegion = '';
  String _cityName = '';
  List<String> _routes = [];
  List<Routes> routes = [];
  Routes? _selectedRouteObject;

  @override
  void initState() {
    super.initState();
    _initializeCustomerId();
    _fetchRoutes();
  }

  Future<void> _initializeCustomerId() async {
    final customerId = await getCustomerId();
    setState(() {
      custId = customerId ?? 0;
    });
  }

  Future<void> _fetchRoutes() async {
    final url = 'https://testapi.wideviewers.com/Route/GetRouteByUser';
    final Map<String, dynamic> reqBody = {
      "userId": widget.userId
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(reqBody),
        headers: {'Content-Type': 'application/json', 'Accept': '/'}
      );
      if (response.statusCode == 200) {
        final ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
        if (apiResponse.isValid) {
          routes = apiResponse.data;
          setState(() {
            _routes = routes.map((route) => route.name).toList();
            if (_routes.isNotEmpty) {
              _selectedRoute = routes[0].name;
              _selectedRouteObject = routes[0];
            }
          });
        } else {
          print('API error: ${apiResponse.message}');
        }
      } else {
        print('Failed to load routes (status code: ${response.statusCode})');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _showRouteBottomSheet(BuildContext context) {
    var fontsize = MediaQuery.of(context).size.width;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Route - $_selectedRegion, $_cityName',
                    style: TextStyle(
                      fontSize: fontsize * 0.05,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Column(
                children: routes.map((route) => _buildRadioOption(route, fontsize * 0.02)).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRadioOption(Routes route, double fontsize) {
    return Column(
      children: [
        RadioListTile<String>(
          title: Text(route.name),
          activeColor: container1,
          value: route.routeId.toString(),
          groupValue: _selectedRoute,
          onChanged: (String? value) {
            setState(() {
              _selectedRoute = route.name;
              _selectedRouteObject = route;
            });
            Navigator.of(context).pop();
          },
          contentPadding: EdgeInsets.zero,
        ),
        Divider(
          color: Colors.grey,
          thickness: 1,
          height: 1,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var fontsize = MediaQuery.of(context).size.width;

    final List<Map<String, dynamic>> items = [
      {
        'image': 'assets/icons/people (2).png',
        'text': 'Customer',
        'route': _selectedRouteObject != null 
            ? CustomerListPage(routeId: _selectedRouteObject!.routeId, userId: widget.userId, custId: custId)
            : null,
      },
      {
        'image': 'assets/icons/shopping-bag (2).png',
        'text': 'Items',
        'route': SettingsPage(),
      },
      {
        'image': 'assets/icons/coupon.png',
        'text': 'Sales',
        'route': InfoPage(),
      },
      {
        'image': 'assets/icons/credit-card (5).png',
        'text': 'Payments',
        'route': ContactPage(),
      },
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
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
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.more_vert_rounded,
                    color: Colors.white, size: 30),
              ),
            ],
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                height: height * 0.25,
                width: width,
                decoration: BoxDecoration(
                  color: container1,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                AssetImage('assets/images/profile man.png'),
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.username,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontsize * 0.04,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '12100',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontsize * 0.08,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        'AED',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: fontsize * 0.04,
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Sales Today',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontsize * 0.03,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '13140',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontsize * 0.08,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        'AED',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: fontsize * 0.04,
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Monthly Sales',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontsize * 0.03,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: height * 0.55,
                padding: EdgeInsets.only(
                  top: 40.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: List.generate(items.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        if (items[index]['route'] != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => items[index]['route'],
                            ),
                          );
                        } else {
                          // Handle the case when the route is not available (e.g., show a message)
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please select a route first.')),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(236, 255, 255, 255),
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(161, 110, 110, 110)
                                  .withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                items[index]['image'],
                                height: 50,
                              ),
                              SizedBox(height: 10),
                              Text(
                                items[index]['text'],
                                style: TextStyle(
                                  color: text1,
                                  fontSize: fontsize * 0.04,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          container1), // Replace with your color constant
                    ),
                    onPressed: () {
                      _showRouteBottomSheet(context);
                    },
                    child: Text(
                      'Route',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: fontsize * 0.04,
                      ),
                    ),
                  ),
                  SizedBox(width: 5.5),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          container1), // Replace with your color constant
                    ),
                    onPressed: () {
                      // Navigator.pop(context);
                    },
                    child: Text(
                      'More',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: fontsize * 0.04,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );}}