import 'package:final_year_project2024/src/screens/registration_page.dart';
import 'package:flutter/material.dart';
import '../services/verification_service.dart';
import 'check_verification_page.dart'; // Import the CheckVerificationPage

class StartVerificationPage extends StatefulWidget {
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
            MaterialPageRoute(builder: (context) => CheckVerificationPage(phone: phone)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to start verification')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid phone number')));
    }
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
              Colors.teal[300]!, // lighter shade of teal
              Colors.teal[900]!, // darker shade of teal
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number (Ex- 07XXXXXXXX)'),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.teal), // background color
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // foreground color
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
