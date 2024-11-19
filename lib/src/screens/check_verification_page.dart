import 'dart:convert';

import 'package:flutter/material.dart';
import '../services/verification_service.dart';
import 'login_page.dart'; // Import the LoginPage
import 'package:http/http.dart' as http;

class CheckVerificationPage extends StatefulWidget {
  final String phone;
  final String email;

  CheckVerificationPage({required this.phone, required this.email});

  @override
  _CheckVerificationPageState createState() => _CheckVerificationPageState();
}

class _CheckVerificationPageState extends State<CheckVerificationPage> {
  final TextEditingController _codeController = TextEditingController();
  bool _registrationSuccess = false; // Define the variable here

  void _checkVerification() async {
    final code = _codeController.text.trim();
    if (code.isNotEmpty) {
      final success = await VerificationService.checkVerification(code);
      if (success) {


        try {
          var response2 = await http.post(
            Uri.parse("https://lasting-proper-midge.ngrok-free.app/api/users/verified"),
            headers: {
              'Content-Type': 'application/json',
              "ngrok-skip-browser-warning": "69420",
            },
            body: jsonEncode({
              'email': widget.email,
            }),
          );

          if (response2.statusCode == 200) {
            setState(() {
              _registrationSuccess = true; // Update the state
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          }
        } catch (e) { }



      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Verification failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text('Check Verification', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFFDF3E7)!, // lighter shade of teal
              Color(0xFFFDF3E7)!, // darker shade of teal
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (_registrationSuccess) // Use the variable here
                  Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.teal[800],
                    child: const Text(
                      'You have successfully registered to the application!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                TextField(
                  controller: _codeController,
                  decoration: const InputDecoration(
                    labelText: 'Verification Code',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _checkVerification,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFDF3E7),
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Check Verification'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
