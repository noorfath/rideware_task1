import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rideware_task1/const.dart';
import 'package:rideware_task1/model/loginmodel.dart';
import 'package:rideware_task1/view/pages/home.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String ipAddress = ''; // Assuming ipAddress is empty for now

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      final body = jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'ipAddress': ipAddress,
      });

      print('Request URL: https://testapi.wideviewers.com/User/Login');
      print('Request Headers: {Content-Type: application/json; charset=UTF-8}');
      print('Request Body: $body');

      HttpOverrides.global = MyHttpOverrides();
      final client = IOClient(
          HttpClient()..badCertificateCallback = (X509Certificate cert, String host, int port) => true);

      final response = await client.post(
        Uri.parse('https://testapi.wideviewers.com/User/Login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Headers: ${response.headers}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final LoginApiResponse responseBody = LoginApiResponse.fromJson(jsonDecode(response.body));
        if (responseBody.isValid) {
          final int userId = responseBody.data.user.id; // Extract userId
          
          // Save userId in shared_preferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('userId', userId);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login successful')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Homepage1(
              username: username,
              userId: userId, // Pass userId to Homepage1
            )),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: Empty response')),
          );
        }
      } else if (response.statusCode == 307) {
        final redirectUrl = response.headers['location'];
        print('Redirect URL: $redirectUrl');
        if (redirectUrl != null) {
          final redirectResponse = await client.post(
            Uri.parse(redirectUrl),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'username': username,
              'password': password,
            }),
          );

          print('Redirect Response Status Code: ${redirectResponse.statusCode}');
          print('Redirect Response Headers: ${redirectResponse.headers}');
          print('Redirect Response Body: ${redirectResponse.body}');

          _handleLoginResponse(redirectResponse);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: Redirect URL is missing')),
          );
        }
      } else {
        _handleLoginResponse(response);
      }
    } catch (e) {
      print('Login failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }

  void _handleLoginResponse(http.Response response) async {
    print('Handling Login Response');
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody.isNotEmpty) {
        final int userId = responseBody['userId']; // Extract userId
        
        // Save userId in shared_preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('userId', userId);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepage1(
            username: _usernameController.text,
            userId: userId, // Pass userId to Homepage1
          )),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: Empty response')),
        );
      }
    } else {
      String errorMessage = 'Login failed: ';
      if (response.body.isNotEmpty) {
         print('Response Status Code: ${response.statusCode}');
        try {
          final responseBody = jsonDecode(response.body);
          errorMessage += responseBody['message'] ?? 'Unknown error';
        } catch (e) {
          errorMessage += 'Unable to parse error message';
        }
      } else {
        errorMessage += response.reasonPhrase ?? 'Unknown reason';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var fontsize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 200),
                    Text(
                      'Welcome !',
                      style: TextStyle(
                        fontSize: fontsize * 0.05,
                        fontFamily: "poppins",
                        color: text1,
                      ),
                    ),
                    SizedBox(height: 80),
                    Material(
                      elevation: 20,
                      shadowColor: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(5),
                          prefixIcon: Icon(
                            size: 15,
                            Icons.person,
                            color: text2,
                          ),
                          hintText: 'User Name',
                          hintStyle: TextStyle(
                            fontSize: fontsize * 0.03,
                            fontFamily: "poppins",
                            color: text2,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Material(
                      elevation: 20.0,
                      borderRadius: BorderRadius.circular(10.0),
                      shadowColor: Colors.white,
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(5),
                          prefixIcon: Icon(
                            size: 15,
                            Icons.lock,
                            color: text2,
                          ),
                          suffixIcon: Icon(
                            Icons.visibility_off,
                            color: text2,
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            fontSize: fontsize * 0.03,
                            fontFamily: "poppins",
                            color: text2,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: text1,
                            fontFamily: "poppins",
                            fontSize: fontsize * 0.03,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: container1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        fixedSize: Size(95, 30),
                      ),
                      child: Text(
                        'Sign',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontsize * 0.04,
                        ),
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
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// Function to retrieve userId from shared_preferences
// Future<int?> getUserId() async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getInt('userId');
// }

// class Homepage1 extends StatelessWidget {
//   final String username;
//   final int userId;

//   const Homepage1({Key? key, required this.username, required this.userId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Your Homepage1 build method implementation
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Homepage1'),
//       ),
//       body: Center(
//         child: Text('Welcome, $username! Your user ID is $userId.'),
//       ),
//     );
//   }
// }
