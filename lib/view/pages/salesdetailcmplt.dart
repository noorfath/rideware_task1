import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rideware_task1/const.dart';

class salescmplt extends StatelessWidget {
  const salescmplt({super.key});

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
            title: Text(
              "Order No",
              style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: Colors.white),
            ),
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
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          'Customer Name',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: fontsize * 0.05,
                                fontFamily: GoogleFonts.poppins().fontFamily),
                          ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Items',
                              style: TextStyle(
                                  fontSize: fontsize * 0.04,
                                  fontFamily: GoogleFonts.poppins().fontFamily),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 150.0),
                            child: Text(
                              'Qty',
                              style: TextStyle(
                                  color: text1,
                                  fontSize: fontsize * 0.04,
                                  fontFamily: GoogleFonts.poppins().fontFamily),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(
                              'Total',
                              style: TextStyle(
                                  color: text1,
                                  fontSize: fontsize * 0.04,
                                  fontFamily: GoogleFonts.poppins().fontFamily),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildSalesItem('Strawberry Cake', 72, fontsize, 01, 72),
                      buildSalesItem('Blackforest Cake', 72, fontsize, 01, 72),
                      buildSalesItem('ButterScotch Cake', 72, fontsize, 01, 72),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 8.0),
                        child: Card(
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
                              buildSummaryRow('Total Amount', 72, 0, fontsize),
                              buildSummaryRow('Tax', 72, 1, fontsize),
                              buildSummaryRow('Discount', 72, 2, fontsize),
                              buildSummaryRow('Total Payable', 72, 3, fontsize),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Print',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontsize * 0.035,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        container1, // Dark red color

                                    textStyle:
                                        TextStyle(fontSize: fontsize * 0.035),
                                    minimumSize: Size(150, 35),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          5), // Add border radius here
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 14.0),
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Share',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontsize * 0.035,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        container1, // Dark red color

                                    textStyle: TextStyle(
                                        fontSize: fontsize * 0.035,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily),
                                    minimumSize: Size(150, 35),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          5), // Add border radius here
                                    ),
                                  )),
                            )
                          ],
                        ),
                      )
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

  Widget buildSummaryRow(String title, int amount, int index, double fontsize) {
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
                  fontSize: fontsize * 0.035,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: text1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              'AED $amount',
              style: TextStyle(
                  fontSize: fontsize * 0.035,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: container1),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSalesItem(
      String title, int price, double fontsize, int quantity, int total) {
    return Container(
      height: 100,
      child: Card(
        color: Colors.white,
        elevation: 2,
        margin: EdgeInsets.symmetric(
          vertical: 2.5,
          horizontal: 5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: fontsize * 0.035,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                    Text(
                      'AED $price',
                      style: TextStyle(
                        fontSize: fontsize * 0.035,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        color: container1,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '$quantity',
                  style: TextStyle(
                    fontSize: fontsize * 0.035,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
              ),
              Text(
                'AED $total',
                style: TextStyle(
                  fontSize: fontsize * 0.035,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: container1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
