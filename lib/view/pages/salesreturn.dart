import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rideware_task1/const.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SalesReturn(),
  ));
}

class SalesReturn extends StatelessWidget {
  const SalesReturn({super.key});

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
              " Sales Return",
              style: TextStyle(
                fontFamily: GoogleFonts.poppins().fontFamily,
                color: Colors.white,
              ),
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
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                width: width,
                padding: EdgeInsets.only(
                    bottom: 130), // Add padding to prevent overlap
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
                      child: Padding(
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
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  'Order Number',
                                  style: TextStyle(
                                    fontSize: fontsize * 0.04,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Text(
                                  'Amt',
                                  style: TextStyle(
                                    fontSize: fontsize * 0.04,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
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
          child: ListTile(
            contentPadding: EdgeInsets.all(10),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Item: Strawberry',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: fontsize * 0.035,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      'Quantity: 4',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: fontsize * 0.035,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Unit Price: \$25.00',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: fontsize * 0.035,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _showBottomSheet(context);
                      },
                      child: Text(
                        'Return Item',
                        style: TextStyle(
                          color: Colors.green,
                          fontFamily: "poppins",
                          fontSize: fontsize * 0.04,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  'Total Price: \$100.00',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: fontsize * 0.035,
                      color: Colors.black,
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

 void _showBottomSheet(BuildContext context) {
  TextEditingController reasonController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  int quantity = 1;
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  var fontsize = MediaQuery.of(context).size.width;

  bool isReplacement = false;
  bool isRefund = false;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Vanilla Cake',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Reason',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: TextField(
                          controller: reasonController,
                          decoration: InputDecoration(contentPadding: EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Remarks',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: TextField(
                          controller: remarksController,
                          decoration: InputDecoration(contentPadding: EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: isReplacement,
                        onChanged: (value) {
                          setState(() {
                            isReplacement = value!;
                          });
                        },
                      ),
<<<<<<< HEAD
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Refund",
                      style: TextStyle(
                        fontSize: fontsize * 0.04,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                    Transform.scale(
                      scale: 0.6,
                      child: Switch(
=======
                      Text('Replacement'),
                      SizedBox(width: 32),
                      Checkbox(
>>>>>>> 109c91722b2639c3609bf887f290baafe47cd005
                        value: isRefund,
                        onChanged: (value) {
                          setState(() {
                            isRefund = value!;
                          });
                        },
                      ),
                      Text('Refund'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantity',
                        style: TextStyle(fontSize: 18),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) {
                                  quantity--;
                                }
                              });
                            },
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Handle form submission logic here
                      Navigator.pop(context);
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
}