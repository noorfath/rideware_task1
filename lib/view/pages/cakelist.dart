import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rideware_task1/const.dart';
import 'package:rideware_task1/model/cakelistmodel.dart';
import 'package:rideware_task1/model/categorymodel.dart';
import 'package:rideware_task1/view/pages/cart.dart';

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
  int quantity = 1;

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
        final Categorymodel categoryModel =
            categorymodelFromJson(response.body);
        setState(() {
          categories.addAll(
              categoryModel.data.map((category) => category.name).toList());
        });
      } else {
        print(
            'Failed to load categories (status code: ${response.statusCode})');
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
        final Cakelistmodel cakelistModel =
            cakelistmodelFromJson(response.body);
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

  List<Datumm> getFilteredItems() {
    if (selectedCategory == 'ALL') {
      return items;
    } else {
      return items
          .where(
              (item) => item.categoryId == categories.indexOf(selectedCategory))
          .toList();
    }
  }

  void _showBottomSheet(Datumm selectedDatum) {
    var fontsize = MediaQuery.of(context).size.width;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetContent(
            fontsize: fontsize, selectedDatum: selectedDatum);
      },
    );
  }

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
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Cart(
                      initialItems: [],
                    ),
                  ));
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
                        padding: const EdgeInsets.only(
                            top: 60.0, right: 30, left: 30),
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
                            // ElevatedButton(
                            //   onPressed: () {},
                            //   child: Text(
                            //     '+ Add',
                            //     style: TextStyle(
                            //       fontFamily: GoogleFonts.poppins().fontFamily,
                            //       fontSize: fontsize * 0.04,
                            //       color: appbarcolor,
                            //     ),
                            //   ),
                            //   style: ElevatedButton.styleFrom(
                            //     fixedSize: Size(100, 45),
                            //     backgroundColor:
                            //         Colors.white, // Replace with your color
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(10),
                            //     ),
                            //   ),
                            // ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                    itemCount: getFilteredItems().length,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          getFilteredItems()[index].name,
                                          style: TextStyle(
                                              fontSize: fontsize * 0.04,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: GoogleFonts.poppins()
                                                  .fontFamily),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'AED ${getFilteredItems()[index].price}',
                                      style: TextStyle(
                                        fontSize: fontsize * 0.04,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                        color: appbarcolor,
                                      ),
                                    ),
                                    Text(
                                      getFilteredItems()[index].description,
                                      style: TextStyle(
                                        fontSize: fontsize * 0.03,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
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
                                      _showBottomSheet(
                                          getFilteredItems()[index]);
                                    },
                                    child: Text(
                                      'Add',
                                      style: TextStyle(
                                        fontSize: fontsize * 0.04,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: appbarcolor,
                                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
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
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? appbarcolor : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: appbarcolor),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: isSelected ? Colors.white : appbarcolor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.poppins().fontFamily),
          ),
        ),
      ),
    );
  }
}

class BottomSheetContent extends StatefulWidget {
  final double fontsize;
  final Datumm selectedDatum;

  BottomSheetContent({required this.fontsize, required this.selectedDatum});

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  int quantity = 1;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _priceController =
        TextEditingController(text: widget.selectedDatum.price.toString());
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.selectedDatum.name,
            style: TextStyle(
              fontSize: widget.fontsize * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Price (AED)',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 8),
          Text(
            widget.selectedDatum.description,
            style: TextStyle(
              fontSize: widget.fontsize * 0.04,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Quantity:',
                style: TextStyle(
                  fontSize: widget.fontsize * 0.05,
                ),
              ),
              SizedBox(width: 16),
              IconButton(
                onPressed: _decrementQuantity,
                icon: Icon(Icons.remove),
              ),
              Text(
                '$quantity',
                style: TextStyle(
                  fontSize: widget.fontsize * 0.05,
                ),
              ),
              IconButton(
                onPressed: _incrementQuantity,
                icon: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Cart(
                    initialItems: [
                      Item(
                        title: widget.selectedDatum.name,
                        price: double.parse(
                            _priceController.text), // Use the entered price
                        quantity: quantity,
                      )
                    ],
                  ),
                ));
              },
              child: Text(
                'Go to Cart',
                style: TextStyle(
                  fontSize: widget.fontsize * 0.05,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: appbarcolor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}