import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rideware_task1/const.dart';
import 'package:rideware_task1/view/pages/orderdetail.dart';
import 'package:rideware_task1/view/pages/salesdetailcmplt.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SalesHistory(),
  ));
}

class SalesHistory extends StatelessWidget {
  const SalesHistory({super.key});

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
              title: Text(
                "Order History",
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
                                    hintText: 'Select Date',
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
                                      String formattedDate =
                                          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                                      print(formattedDate);
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
                              buildCustomerListView(context, fontsize),
                              buildCustomerListView(context, fontsize),
                              buildCustomerListView(context, fontsize),
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

  Widget buildCustomerListView(BuildContext context, double fontsize) {
    // Sample order list with status
    List<Map<String, String>> orders = [
      {"orderNo": "12345", "status": "Completed"},
      {"orderNo": "12346", "status": "Pending"},
      {"orderNo": "12347", "status": "Completed"},
      {"orderNo": "12348", "status": "Pending"},
    ];

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        String status = orders[index]["status"]!;
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
                      'No: ${orders[index]["orderNo"]}',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: fontsize * 0.04,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      'Status: $status',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: fontsize * 0.04,
                          color: status == "Completed"
                              ? Colors.green
                              : Colors.red,
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
                      ' Ahammed',
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
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ' 2024-06-06 12:34 PM',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: fontsize * 0.035,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      'Paycheck: \$90.00',
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
              if (status == 'Completed') {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => salescmplt()),
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => orderdetail()),
                );
              }
            },
          ),
        );
      },
    );
  }
}
