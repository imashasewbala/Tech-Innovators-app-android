import 'dart:convert';

import 'package:final_year_project2024/src/screens/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/verification_service.dart';
import 'check_verification_page.dart'; // Import the CheckVerificationPage

class StartVerificationPage extends StatefulWidget {
  final String email;

  StartVerificationPage({required this.email});

  @override
  _StartVerificationPageState createState() => _StartVerificationPageState();
}

class _StartVerificationPageState extends State<StartVerificationPage> {
  final TextEditingController _phoneController = TextEditingController(text: RegistrationPage.OTP_Phone);


  void _startVerification() async {
    final phone = _phoneController.text.trim();
    if (phone.isNotEmpty) {
      try {
        final success = await VerificationService.startVerification(phone);
        if (success) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CheckVerificationPage(phone: phone,email:widget.email)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to start verification')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Errors: ${e.toString()}')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid phone number')));
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Verification'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFDF3E7)!, // lighter shade of teal
              Color(0xFFFDF3E7)!, // darker shade of teal
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image widget here
              Image.asset(
                'assets/images/Load4.png', // replace with your image path
                height: 400, // adjust height as needed
                width: double.infinity, // take full width
                fit: BoxFit.cover, // adjust the image's fit property as needed
              ),
              SizedBox(height:16.0),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number (Ex- 07XXXXXXXX)',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.transparent), // set transparent background color
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white), // set text color to white
                ),
                onPressed: _startVerification,
                child: Text('Start Verification'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}