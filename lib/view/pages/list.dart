import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rideware_task1/const.dart';
import 'package:rideware_task1/view/pages/almadina.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CustomerListPage(),
  ));
}

class CustomerListPage extends StatelessWidget {
  const CustomerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var fontsize = MediaQuery.of(context).size.width;

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
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily),
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
                          itemCount: 4,
                          itemBuilder: (context, index) {
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
                                    height: 40),
                                title: Text(
                                  'Al Arz Bakery',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: fontsize * 0.04,
                                        color: Colors.black),
                                  ),
                                ),
                                subtitle: Text(
                                  '050 233 3336',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: fontsize * 0.035,
                                      color: text1,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Almadina()));
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
