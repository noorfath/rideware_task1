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
    home: ReturnHistory(),
  ));
}

class ReturnHistory extends StatefulWidget {
  const ReturnHistory({super.key});

  @override
  _ReturnHistoryState createState() => _ReturnHistoryState();
}

class _ReturnHistoryState extends State<ReturnHistory> {
  String dropdownValue = 'All';

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
              "Return History",
              style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: Colors.white),
            ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 28.0),
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
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right:20.0),
                              child: IconButton(
                                icon: Icon(Icons.calendar_today, color: Colors.white),
                                onPressed: () {
                                  // Add your calendar functionality here
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, right: 30, left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5.0),
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontSize: fontsize * 0.035,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search_outlined,
                                    color: appbarcolor,
                                    size: 40,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 2),
                            Container(
                              width: 140, // Set the width of the container
                              height: 47, // Set the height of the container
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  icon: Icon(Icons.arrow_downward,
                                      color: appbarcolor),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(
                                    color: text1,
                                    fontSize: fontsize * 0.035,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                    });
                                  },
                                  items: <String>['All', 'Pending', 'Delivered']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
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
      physics: NeverScrollableScrollPhysics(), // To prevent scrolling inside SingleChildScrollView
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
          child: Column(
            children: [
              ListTile(
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
                              fontSize: fontsize * 0.035,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          'Status: Completed',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: fontsize * 0.035,
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
                          '2024-06-06 12:34 PM',
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
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(builder: (context) => Almadina(username: '', routeId: '', cityName: '',)),
                  // );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
        );
      },
    );
  }
}
