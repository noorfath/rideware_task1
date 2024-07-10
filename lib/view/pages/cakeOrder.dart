// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:rideware_task1/const.dart';
// import 'package:rideware_task1/view/pages/cart.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
//   runApp(MaterialApp(
//     home: Order(),
//     debugShowCheckedModeBanner: false,
//   ));
// }

// class Order extends StatefulWidget {
//   const Order({super.key});

//   @override
//   State<Order> createState() => _OrderState();
// }

// class _OrderState extends State<Order> {
//   int _quantity = 0;
//   final FocusNode _priceFocusNode = FocusNode();
//   final FocusNode _taxFocusNode = FocusNode();
//   final FocusNode _discountFocusNode = FocusNode();
//   final FocusNode _unitFocusNode = FocusNode();
//   final FocusNode _freeFocusNode = FocusNode();

//   void _incrementQuantity() {
//     setState(() {
//       _quantity++;
//     });
//   }

//   void _decrementQuantity() {
//     setState(() {
//       if (_quantity > 0) {
//         _quantity--;
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _priceFocusNode.dispose();
//     _taxFocusNode.dispose();
//     _discountFocusNode.dispose();
//     _unitFocusNode.dispose();
//     _freeFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     var fontsize = MediaQuery.of(context).size.width;

//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.dark,
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(45.0),
//           child: AppBar(
//             backgroundColor: appbarcolor,
//             leading: IconButton(
//               icon: Icon(
//                 Icons.arrow_back_ios_new_rounded,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             actions: [
//               IconButton(
//                 onPressed: () {
//                   Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (context) => cart()));
//                 },
//                 icon: Icon(Icons.shopping_cart_rounded),
//                 color: Colors.white,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(right: 10.0),
//                 child: Icon(
//                   Icons.more_vert_rounded,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             width: width,
//             child: Column(
//               children: [
//                 Container(
//                   height: height * 0.20,
//                   width: width,
//                   decoration: BoxDecoration(
//                     color: container1,
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(20),
//                       bottomRight: Radius.circular(20),
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             top: 60.0, right: 30, left: 30),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Expanded(
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                   contentPadding: EdgeInsets.all(5.0),
//                                   hintText: 'Search',
//                                   hintStyle: TextStyle(
//                                     fontFamily:
//                                         GoogleFonts.poppins().fontFamily,
//                                     fontSize: fontsize * 0.03,
//                                   ),
//                                   prefixIcon: Icon(
//                                     Icons.search_outlined,
//                                     color: appbarcolor,
//                                     size: 40,
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 2),
//                             ElevatedButton(
//                               onPressed: () {},
//                               child: Text(
//                                 '+ Add',
//                                 style: TextStyle(
//                                   fontFamily: GoogleFonts.poppins().fontFamily,
//                                   fontSize: fontsize * 0.04,
//                                   color: appbarcolor,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 fixedSize: Size(100, 45),
//                                 backgroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       CategoryButton(text: 'ALL', isSelected: false),
//                       CategoryButton(text: 'Cake', isSelected: true),
//                       CategoryButton(text: 'Bun', isSelected: false),
//                       CategoryButton(text: 'Bread', isSelected: false),
//                       CategoryButton(text: 'Biscuit', isSelected: false),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 26),
//                 Container(
//                   padding: EdgeInsets.all(26),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 1,
//                         blurRadius: 10,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Image.asset(
//                             'assets/images/cake.jpg',
//                             height: 50,
//                             width: 50,
//                             fit: BoxFit.cover,
//                           ),
//                           SizedBox(width: 10),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Strawberry Cake',
//                                 style: TextStyle(
//                                   fontSize: fontsize * 0.04,
//                                   fontFamily: GoogleFonts.poppins().fontFamily,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     'Stock ',
//                                     style: TextStyle(
//                                       color: text1,
//                                       fontSize: fontsize * 0.04,
//                                       fontFamily:
//                                           GoogleFonts.poppins().fontFamily,
//                                       fontWeight: FontWeight.w100,
//                                     ),
//                                   ),
//                                   Text(
//                                     'In',
//                                     style: TextStyle(
//                                       color: Colors.green,
//                                       fontSize: fontsize * 0.04,
//                                       fontFamily:
//                                           GoogleFonts.poppins().fontFamily,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Price',
//                                   style: TextStyle(
//                                     fontSize: fontsize * 0.04,
//                                     fontFamily:
//                                         GoogleFonts.poppins().fontFamily,
//                                   ),
//                                 ),
//                                 Focus(
//                                   focusNode: _priceFocusNode,
//                                   child: AnimatedContainer(
//                                     duration: Duration(milliseconds: 300),
//                                     decoration: BoxDecoration(
//                                       boxShadow: _priceFocusNode.hasFocus
//                                           ? [
//                                               BoxShadow(
//                                                   color: Colors.black26,
//                                                   blurRadius: 10)
//                                             ]
//                                           : [],
//                                     ),
//                                     child: Material(
//                                       elevation:
//                                           _priceFocusNode.hasFocus ? 5 : 0,
//                                       child: TextField(
//                                         decoration: InputDecoration(
//                                           border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10.0),
//                                             borderSide:
//                                                 BorderSide(color: container1),
//                                           ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             borderSide:
//                                                 BorderSide(color: Colors.grey),
//                                           ),
//                                           filled: true,
//                                           fillColor: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(width: 16),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Tax',
//                                   style: TextStyle(
//                                     fontSize: fontsize * 0.04,
//                                     fontFamily:
//                                         GoogleFonts.poppins().fontFamily,
//                                   ),
//                                 ),
//                                 Focus(
//                                   focusNode: _taxFocusNode,
//                                   child: AnimatedContainer(
//                                     duration: Duration(milliseconds: 300),
//                                     decoration: BoxDecoration(
//                                       boxShadow: _taxFocusNode.hasFocus
//                                           ? [
//                                               BoxShadow(
//                                                   color: Colors.black26,
//                                                   blurRadius: 10)
//                                             ]
//                                           : [],
//                                     ),
//                                     child: Material(
//                                       elevation: _taxFocusNode.hasFocus ? 5 : 0,
//                                       child: TextField(
//                                         decoration: InputDecoration(
//                                           border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10.0),
//                                             borderSide:
//                                                 BorderSide(color: container1),
//                                           ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             borderSide:
//                                                 BorderSide(color: Colors.grey),
//                                           ),
//                                           filled: true,
//                                           fillColor: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Discount',
//                                   style: TextStyle(
//                                     fontSize: fontsize * 0.04,
//                                     fontFamily:
//                                         GoogleFonts.poppins().fontFamily,
//                                   ),
//                                 ),
//                                 Focus(
//                                   focusNode: _discountFocusNode,
//                                   child: AnimatedContainer(
//                                     duration: Duration(milliseconds: 300),
//                                     decoration: BoxDecoration(
//                                       boxShadow: _discountFocusNode.hasFocus
//                                           ? [
//                                               BoxShadow(
//                                                   color: Colors.black26,
//                                                   blurRadius: 10)
//                                             ]
//                                           : [],
//                                     ),
//                                     child: Material(
//                                       elevation:
//                                           _discountFocusNode.hasFocus ? 5 : 0,
//                                       child: TextField(
//                                         decoration: InputDecoration(
//                                           border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10.0),
//                                             borderSide:
//                                                 BorderSide(color: container1),
//                                           ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             borderSide:
//                                                 BorderSide(color: Colors.grey),
//                                           ),
//                                           filled: true,
//                                           fillColor: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(width: 16),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Discount Type',
//                                   style: TextStyle(
//                                     fontSize: fontsize * 0.04,
//                                     fontFamily:
//                                         GoogleFonts.poppins().fontFamily,
//                                   ),
//                                 ),
//                                 Material(
//                                   elevation: 5,
//                                   child: DropdownButtonFormField(
//                                     decoration: InputDecoration(
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.0),
//                                         borderSide:
//                                             BorderSide(color: container1),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                       ),
//                                       filled: true,
//                                       fillColor: Colors.white,
//                                     ),
//                                     items: [
//                                       DropdownMenuItem(
//                                           child: Text('Type 1'), value: '1'),
//                                       DropdownMenuItem(
//                                           child: Text('Type 2'), value: '2'),
//                                     ],
//                                     onChanged: (value) {},
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Unit',
//                                   style: TextStyle(
//                                     fontSize: fontsize * 0.04,
//                                     fontFamily:
//                                         GoogleFonts.poppins().fontFamily,
//                                   ),
//                                 ),
//                                 Focus(
//                                   focusNode: _unitFocusNode,
//                                   child: AnimatedContainer(
//                                     duration: Duration(milliseconds: 300),
//                                     decoration: BoxDecoration(
//                                       boxShadow: _unitFocusNode.hasFocus
//                                           ? [
//                                               BoxShadow(
//                                                   color: Colors.black26,
//                                                   blurRadius: 10)
//                                             ]
//                                           : [],
//                                     ),
//                                     child: Material(
//                                       elevation:
//                                           _unitFocusNode.hasFocus ? 5 : 0,
//                                       child: TextField(
//                                         decoration: InputDecoration(
//                                           border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10.0),
//                                             borderSide:
//                                                 BorderSide(color: container1),
//                                           ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             borderSide:
//                                                 BorderSide(color: Colors.grey),
//                                           ),
//                                           filled: true,
//                                           fillColor: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(width: 16),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Free',
//                                   style: TextStyle(
//                                     fontSize: fontsize * 0.04,
//                                     fontFamily:
//                                         GoogleFonts.poppins().fontFamily,
//                                   ),
//                                 ),
//                                 Focus(
//                                   focusNode: _freeFocusNode,
//                                   child: AnimatedContainer(
//                                     duration: Duration(milliseconds: 300),
//                                     decoration: BoxDecoration(
//                                       boxShadow: _freeFocusNode.hasFocus
//                                           ? [
//                                               BoxShadow(
//                                                   color: Colors.black26,
//                                                   blurRadius: 10)
//                                             ]
//                                           : [],
//                                     ),
//                                     child: Material(
//                                       elevation:
//                                           _freeFocusNode.hasFocus ? 5 : 0,
//                                       child: TextField(
//                                         decoration: InputDecoration(
//                                           border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10.0),
//                                             borderSide:
//                                                 BorderSide(color: container1),
//                                           ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             borderSide:
//                                                 BorderSide(color: Colors.grey),
//                                           ),
//                                           filled: true,
//                                           fillColor: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16),
//                       Container(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             IconButton(
//                               onPressed: _decrementQuantity,
//                               icon: Icon(Icons.remove),
//                             ),
//                             Text(
//                               ' Quantity',
//                               style: TextStyle(
//                                 fontSize: fontsize * 0.04,
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: _incrementQuantity,
//                               icon: Icon(Icons.add),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           ElevatedButton(
//                             onPressed: () {},
//                             child: Text(
//                               'Cancel',
//                               style: TextStyle(
//                                 fontFamily: GoogleFonts.poppins().fontFamily,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor:
//                                   const Color.fromARGB(255, 203, 202, 202),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 8),
//                           ElevatedButton(
//                             onPressed: () {},
//                             child: Text(
//                               'Save',
//                               style: TextStyle(
//                                 fontFamily: GoogleFonts.poppins().fontFamily,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: container1,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CategoryButton extends StatelessWidget {
//   final String text;
//   final bool isSelected;

//   const CategoryButton({
//     Key? key,
//     required this.text,
//     required this.isSelected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 4.0),
//       child: ElevatedButton(
//         onPressed: () {},
//         child: Text(
//           text,
//           style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
//         ),
//         style: ElevatedButton.styleFrom(
//           foregroundColor: isSelected ? Colors.white : Colors.black,
//           backgroundColor: isSelected ? container1 : Colors.grey[300],
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//     );
//   }
// }
