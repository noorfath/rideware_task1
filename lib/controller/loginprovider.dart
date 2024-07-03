import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rideware_task1/view/pages/home.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final String username = usernameController.text;
    final String password = passwordController.text;
    final String ipAddress = '';

    final url = Uri.parse('http://testapi.wideviewers.com/User/Login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
          'ipAddress': ipAddress,
        }),
      );

      if (response.statusCode == 200) {
        // Handle successful login
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final id = responseBody['userId'];
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Homepage1(username: username, userId: id,)),
        );
      } else {
        // Handle error
        final errorMessage = json.decode(response.body)['message'];
        _showErrorDialog(context, errorMessage);
      }
    } catch (e) {
      // Handle exception
      _showErrorDialog(context, 'An error occurred. Please try again.');
      print('Exception during login: $e'); // Print the error for debugging purposes
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Login Failed'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
