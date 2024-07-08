import 'package:flutter/material.dart';
import '../services/verification_service.dart';
import 'login_page.dart'; // Import the LoginPage

class CheckVerificationPage extends StatefulWidget {
  final String phone;

  CheckVerificationPage({required this.phone});

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
        setState(() {
          _registrationSuccess = true; // Update the state
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
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
            colors: [Colors.teal[300]!, Colors.teal[900]!],
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
                    backgroundColor: Colors.teal[900],
                    foregroundColor: Colors.white,
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
