import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rideware_task1/const.dart';
import 'package:rideware_task1/model/cakelistmodel.dart';
import 'package:rideware_task1/model/categorymodel.dart';
import 'package:rideware_task1/view/pages/cakeOrder.dart';
import 'package:rideware_task1/view/pages/cart.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: ItemListPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class ItemListPage extends StatefulWidget {
  @override
  _ItemListPageState createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  List<Datumm> items = [];
  List<String> categories = ['ALL'];
  String selectedCategory = 'ALL';

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _fetchItems();
  }

  Future<void> _fetchCategories() async {
    final url = 'https://testapi.wideviewers.com/FGCategory/GetSalesCategory';
    Map<String, dynamic> requestBody = {};

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(requestBody), // Encode request body
        headers: {'Content-Type': 'application/json', 'Accept': '/'},
      );

      if (response.statusCode == 200) {
        print('API call successful');
        final Categorymodel categoryModel = categorymodelFromJson(response.body);
        setState(() {
          categories.addAll(categoryModel.data.map((category) => category.name).toList());
        });
      } else {
        print('Failed to load categories (status code: ${response.statusCode})');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _fetchItems() async {
    final url = 'https://testapi.wideviewers.com/FGItem/GetSalesItems';
    Map<String, dynamic> requestBody = {};

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(requestBody), // Encode request body
        headers: {'Content-Type': 'application/json', 'Accept': '/'},
      );

      if (response.statusCode == 200) {
        print('API call successful');
        final Cakelistmodel cakelistModel = cakelistmodelFromJson(response.body);
        setState(() {
          items = cakelistModel.data;
        });
      } else {
        print('Failed to load items (status code: ${response.statusCode})');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var fontsize = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // Use Brightness.light for white icons
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
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => cart()));
                },
                icon: Icon(Icons.shopping_cart_rounded),
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
                        padding: const EdgeInsets.only(top: 60.0, right: 30, left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5.0),
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    fontSize: fontsize * 0.03,
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
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                '+ Add',
                                style: TextStyle(
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontSize: fontsize * 0.04,
                                  color: appbarcolor,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(100, 45),
                                backgroundColor: Colors.white, // Replace with your color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                // Category Buttons
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories.map((category) {
                      return CategoryButton(
                        text: category,
                        isSelected: selectedCategory == category,
                        onTap: () {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              // Image.network(
                              //   items[index].imgurl,
                              //   height: 80,
                              //   width: 80,
                              //   fit: BoxFit.cover,
                              // ),
                              Image.asset(
                                    'assets/images/cake.jpg',
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          items[index].name,
                                          style: TextStyle(
                                            fontSize: fontsize * 0.04,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'AED ${items[index].price}',
                                      style: TextStyle(
                                        fontSize: fontsize * 0.04,
                                        fontFamily: GoogleFonts.poppins().fontFamily,
                                        color: appbarcolor,
                                      ),
                                    ),
                                    Text(
                                      items[index].description,
                                      style: TextStyle(
                                        fontSize: fontsize * 0.03,
                                        fontFamily: GoogleFonts.poppins().fontFamily,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => Order()),
                                      );
                                    },
                                    child: Text(
                                      '+ Add',
                                      style: TextStyle(
                                        fontSize: fontsize * 0.04,
                                        fontFamily: GoogleFonts.poppins().fontFamily,
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(30, 30),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      backgroundColor: container1, // Dark red color
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : Colors.black,
          backgroundColor: isSelected ? container1 : Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
