import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rideware_task1/const.dart';
import 'package:rideware_task1/view/pages/login.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var fontsize = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 270,
                    ),
                    Material(
                      elevation: 20.0,
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.white,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(size: 18.0, Icons.email, color: text2),
                          hintText: 'Email Address',
                          hintStyle: TextStyle(
                              color: text2,
                              fontFamily: "poppins",
                              fontSize: fontsize * 0.03),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.all(5.0),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: container1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        shadowColor: Colors.grey,
                        fixedSize: Size(160, 30),
                      ),
                      child: Text(
                        'Reset Password',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: fontsize * 0.03,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 120),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'I know my password',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: text1,
                              fontSize: fontsize * 0.03,
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignupScreen()));
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontFamily: "poppins", color: appbarcolor),
                            ))
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
}
