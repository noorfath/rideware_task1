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
            leading:  IconButton(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Strawberry',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: fontsize * 0.04,
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
                    ElevatedButton.icon(
                      onPressed: () {
                        _showBottomSheet(context);
                      },
                      icon: Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                      ),
                      label: Text('Add to Cart',
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appbarcolor,
                      ),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Item : Strawberry',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: fontsize * 0.035,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              'Unit Price: \$25.00',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: fontsize * 0.035,
                                  color: Colors.black,
                                ),
                              ),
                            ),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Quantity: 4',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: fontsize * 0.035,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              'Return',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: fontsize * 0.035,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                // onTap: () {
                //   Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => Almadina()),
                //   );
                // },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context) {
  int quantity = 1;
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  var fontsize = MediaQuery.of(context).size.width;

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          double unitPrice = 99.99;
          double totalPrice = unitPrice * quantity;
          TextEditingController reasonController = TextEditingController();

          return Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            height: 450,
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        // Image on the left side
                        Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage("assets/images/cake.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        // Name and price on the right side
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Product Name',
                                style: TextStyle(
                                  fontSize: fontsize * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                '\$$unitPrice',
                                style: TextStyle(
                                  fontSize: fontsize * 0.04,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 16.0),
                              Row(
                                children: [
                                  Text(
                                    'Total: \$${totalPrice.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: fontsize * 0.04,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (quantity > 1) {
                                          quantity--;
                                        }
                                        totalPrice = unitPrice * quantity;
                                      });
                                    },
                                  ),
                                  Text(
                                    '$quantity',
                                    style: TextStyle(
                                      fontSize: fontsize * 0.03,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        quantity++;
                                        totalPrice = unitPrice * quantity;
                                      });
                                    },
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
                SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Reason for return",
                    style: TextStyle(
                      fontSize: fontsize * 0.04,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(height: 120,width: double.infinity,
                      child: TextField(
                        controller: reasonController,
                        maxLines: null,
                        decoration: InputDecoration(border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,),
                    
                        
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle save action
                    String reason = reasonController.text;
                    // Implement your save logic here
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appbarcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
}