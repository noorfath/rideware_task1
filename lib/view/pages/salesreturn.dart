import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rideware_task1/const.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SalesReturn(soId: 123), // Replace with your actual soId
  ));
}

class SalesReturn extends StatefulWidget {
  final int soId;

  const SalesReturn({Key? key, required this.soId}) : super(key: key);

  @override
  _SalesReturnState createState() => _SalesReturnState();
}

class _SalesReturnState extends State<SalesReturn> {
  late Future<Customermodel?> salesData;

  @override
  void initState() {
    super.initState();
    salesData = fetchSalesData(widget.soId);
  }

  Future<Customermodel?> fetchSalesData(int soId) async {
    try {
      final response = await http.post(
        Uri.parse('https://testapi.wideviewers.com/Sales/GetSOById'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': soId}),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData != null && jsonData['data'] != null) {
          return Customermodel.fromJson(jsonData['data']);
        }
      }
    } catch (e) {
      print('Failed to load sales data: $e');
    }
    return null;
  }

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
            title: Text(
              "Sales Return",
              style: TextStyle(
                fontFamily: GoogleFonts.poppins().fontFamily,
                color: Colors.white,
              ),
            ),
            backgroundColor: container1,
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
        body: FutureBuilder<Customermodel?>(
          future: salesData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data != null) {
              final data = snapshot.data!;
              return Stack(
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
                                          backgroundImage: AssetImage('assets/images/profile man.png'),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        data.customerName,
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
                                        'Order Number: ${data.soId}',
                                        style: TextStyle(
                                          fontSize: fontsize * 0.04,
                                          fontFamily: GoogleFonts.poppins().fontFamily,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 12.0),
                                      child: Text(
                                        'Amt: ${data.totalafterVat}',
                                        style: TextStyle(
                                          fontSize: fontsize * 0.04,
                                          fontFamily: GoogleFonts.poppins().fontFamily,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: buildCustomerListView(context, fontsize, data),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }

  Widget buildCustomerListView(BuildContext context, double fontsize, Customermodel data) {
    final items = data.detail;
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
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
                      'Item: ${item.itemName}',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: fontsize * 0.035,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      'Quantity: ${item.quantity}',
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
                      'Unit Price: ${item.price}',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: fontsize * 0.035,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _showBottomSheet(context, item.itemName);
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
                  'Total Price: ${item.total}',
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
 void _showBottomSheet(BuildContext context, String itemName) {
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
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8.0),
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
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8.0),
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
                        
                        Text('Replacement'),
                        Checkbox(
                          value: isReplacement,
                          onChanged: (value) {
                            setState(() {
                              isReplacement = value!;
                            });
                          },
                        ),
                        SizedBox(width: 32),
                      
                        Text('Refund'),
                         Checkbox(
                          value: isRefund,
                          onChanged: (value) {
                            setState(() {
                              isRefund = value!;
                            });
                          },
                        ),
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
                    Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle form submission logic here
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              backgroundColor:Colors.white),
                          child: Text(
                            'cancel',
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,fontSize: fontsize*0.03,
                                color: text1),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle form submission logic here
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              backgroundColor:appbarcolor),
                          child: Text('Save',style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,fontSize: fontsize*0.03,
                                color: text1),),
                        ),
                      ],
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
class Customermodel {
  final int soId;
  final String customerName;
  final double totalafterVat;
  final List<Detail> detail;

  Customermodel({
    required this.soId,
    required this.customerName,
    required this.totalafterVat,
    required this.detail,
  });

  factory Customermodel.fromJson(Map<String, dynamic> json) {
    var list = json['detail'] as List;
    List<Detail> detailList = list.map((i) => Detail.fromJson(i)).toList();

    return Customermodel(
      soId: (json['soId'] as num).toInt(),
      customerName: json['customerName'],
      totalafterVat: (json['totalafterVat'] as num).toDouble(),
      detail: detailList,
    );
  }
}

class Detail {
  final String itemName;
  final int quantity;
  final double price;
  final double total;

  Detail({
    required this.itemName,
    required this.quantity,
    required this.price,
    required this.total,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      itemName: json['itemName'],
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );
  }
}
