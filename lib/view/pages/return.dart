import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rideware_task1/const.dart';
import 'package:rideware_task1/view/pages/salesreturn.dart';

class ReturnSalesPage extends StatefulWidget {
  ReturnSalesPage({super.key});

  @override
  ReturnSalesPageState createState() => ReturnSalesPageState();
}

class ReturnSalesPageState extends State<ReturnSalesPage> {
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
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'All',
                                style: TextStyle(
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontSize: fontsize * 0.04,
                                  color: appbarcolor,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(100, 45),
                                backgroundColor:
                                    Colors.white, // Replace with your color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
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
}

Widget buildCustomerListView(BuildContext context, double fontsize) {
  return ListView.builder(
    physics:
        NeverScrollableScrollPhysics(), // To prevent scrolling inside SingleChildScrollView
    shrinkWrap: true, // To allow ListView to take minimum space needed
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
          contentPadding: EdgeInsets.all(10),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'No: 12345',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: fontsize * 0.04,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    'No of items',
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
                    'Ahammed',
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
                    '2024-06-06 12:34 PM',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: fontsize * 0.035,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    'Total: \$100.00',
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
                      builder: (context) => SalesReturn()),
            );
          },
        ),
      );
    },
  );
}