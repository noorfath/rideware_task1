import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rideware_task1/const.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Payments(),
  ));
}

class Payments extends StatelessWidget {
  const Payments({Key? key}) : super(key: key);

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
            backgroundColor:appbarcolor, // Replace with your appbar color
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
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                width: width,
                padding: EdgeInsets.only(bottom: 130),
                child: Column(
                  children: [
                    Container(
                      height: height * 0.20,
                      width: width,
                      decoration: BoxDecoration(
                        color: container1, // Replace with your container color
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 36.0),
                                  child: Text(
                                    'Payments',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontsize * 0.05,
                                        fontFamily: GoogleFonts.poppins().fontFamily,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                hintText: 'Invoice No',
                                hintStyle: TextStyle(
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontSize: fontsize * 0.04,
                                ),
                                suffixIcon: Icon(
                                  Icons.search_outlined,
                                  color: appbarcolor,
                                  size: 30,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: buildCustomerListView(context, fontsize),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, -1),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCustomerListView(BuildContext context, double fontsize) {
    List<Map<String, String>> invoices = [
      {"invoiceNo": "001234", "totalAmount": "\$100.00"},
      {"invoiceNo": "001235", "totalAmount": "\$200.00"},
      {"invoiceNo": "001236", "totalAmount": "\$300.00"},
      {"invoiceNo": "001237", "totalAmount": "\$400.00"},
    ];

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        String invoiceNo = invoices[index]['invoiceNo']!;
        String totalAmount = invoices[index]['totalAmount']!;

        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            onTap: () {
              _showBottomSheet(context, invoiceNo, totalAmount);
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (bool? value) {
                      print("Checkbox changed: $value");
                    },
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Invoice No: $invoiceNo',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: fontsize * 0.035,
                              color: Colors.black,
                            ),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Total: $totalAmount',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: fontsize * 0.035,
                              color: Colors.black,
                            ),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Date: 2024-06-15',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: fontsize * 0.035,
                                    color: Colors.black,
                                  ),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Due: 2024-07-15',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: fontsize * 0.035,
                                    color: Colors.black,
                                  ),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context, String invoiceNo, String totalAmount) {
    final FocusNode _amountFocusNode = FocusNode();
    final FocusNode _typeFocusNode = FocusNode();
    final FocusNode _remarksFocusNode = FocusNode();
    var fontsize = MediaQuery.of(context).size.width;


    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Invoice No: $invoiceNo',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Total: $totalAmount',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("Amount"),
                        SizedBox(height: 5),
                        Focus(
                                  focusNode: _remarksFocusNode,
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    decoration: BoxDecoration(
                                      boxShadow: _remarksFocusNode.hasFocus
                                          ? [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 10)
                                            ]
                                          : [],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation:
                                          _remarksFocusNode.hasFocus ? 5 : 0,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide:
                                                BorderSide(color: container1),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        SizedBox(height: 10),
                        Text("Type"),
                        SizedBox(height: 5),
                        DropdownButtonFormField<String>(
                          elevation: 5,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                            
                              borderRadius: BorderRadius.circular(10),
                              // borderSide: BorderSide.none
                              
                            ),
                            
                            
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          items: ['Card', 'Cash']
                              .map((String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (String? newValue) {
                            // Handle dropdown change
                          },
                        ),
                        SizedBox(height: 10),
                        Text("Remarks"),
                        SizedBox(height: 5),
                        Focus(
                                  focusNode: _remarksFocusNode,
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    decoration: BoxDecoration(
                                      boxShadow: _remarksFocusNode.hasFocus
                                          ? [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 10)
                                            ]
                                          : [],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation:
                                          _remarksFocusNode.hasFocus ? 5 : 0,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide:
                                                BorderSide(color: container1),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle submit logic
                  },
                  child: Text('Submit',
                  style:TextStyle(color: Colors.white) ,),
                  style: ElevatedButton.styleFrom(
                          backgroundColor: container1,
                          textStyle: TextStyle(fontSize: fontsize * 0.035),
                          minimumSize: Size(150, 35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
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
