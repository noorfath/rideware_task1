import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rideware_task1/controller/modelclass.dart';
import 'package:rideware_task1/view/pages/Returnhistory.dart';
import 'package:rideware_task1/view/pages/cakelist.dart';
import 'package:rideware_task1/view/pages/paymenthistory.dart';
import 'package:rideware_task1/view/pages/payments.dart';
import 'package:rideware_task1/view/pages/return.dart';
import 'package:rideware_task1/view/pages/sales.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../const.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
//   runApp(MaterialApp(
//     home: Almadina(),
//     debugShowCheckedModeBanner: false,
//   ));
// }
 Future<int?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('userId');
}

Future<int?> getCustomerId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('customerId');
}

class Almadina extends StatelessWidget {
  final int userId;
  final int custId;
  
  const Almadina({super.key, required customer, required this.userId, required this.custId});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var fontsize = MediaQuery.of(context).size.width;

    final List<Map<String, dynamic>> items = [
      {
        'image': 'assets/icons/coupon.png',
        'text': 'New Sales',
        'route': ItemListPage()
      },
      {
        'image': 'assets/icons/history (1).png',
        'text': 'Sales History',
        'route': SalesHistory(userId: userId, customerId: custId)
      },
      {
        'image': 'assets/icons/return.png',
        'text': 'Return',
        'route': ReturnSalesPage(userId: userId, customerId: custId)
      },
      {
        'image': 'assets/icons/history (1).png',
        'text': 'Return History',
        'route': ReturnHistory()
      },
      {
        'image': 'assets/icons/credit-card (5).png',
        'text': 'Payments',
        'route': Payments()
      },
      {
        'image': 'assets/icons/transaction-history.png',
        'text': 'Payment History',
        'route': PaymentHistoryPage()
      },
      {
        'image': 'assets/icons/transaction.png',
        'text': 'Transaction',
        'route': HomeDetailPage()
      },
      {
        'image': 'assets/icons/location (2).png',
        'text': 'Market Visit     ',
        'route': SettingsPage()
      },
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              Brightness.dark, // Use Brightness.light for white icons
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
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.phone),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () {},
                  icon: FaIcon(FontAwesomeIcons.whatsapp),
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
                child: Column(children: [
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
                          padding: const EdgeInsets.only(top: 30.0, left: 22.0),
                          child: Text(
                            'Al Madeena Grocery',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: fontsize * 0.045,
                                  fontFamily: GoogleFonts.poppins().fontFamily),
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
                                  fontFamily: GoogleFonts.poppins().fontFamily),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, left: 22.0),
                          child: Text(
                            'Ahammed',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: fontsize * 0.045,
                                  fontFamily: GoogleFonts.poppins().fontFamily),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      height: height * 0.68,
                      width: width,
                      child: GridView.count(
                        crossAxisCount: 2, // 2 columns
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 15.0,
                        children: List.generate(items.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => items[index]['route'],
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(233, 253, 253, 253),
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(48, 145, 145, 145)
                                        .withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 6,
                                    offset: Offset(5, 3),
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
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
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
                  ),
                ])),
          ),
        ));
  }
}