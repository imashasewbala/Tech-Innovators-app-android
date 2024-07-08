import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VerificationService {
  static const String _startUrl = 'https://verify1-9792-sjb4uz.twil.io/start-verify';
  static const String _checkUrl = 'https://verify1-9792-sjb4uz.twil.io/check-verify';
  static var _formattedPhone = '';

  static Future<bool> startVerification(String phone) async {
    phone = '+94' + phone.substring(1);
    _formattedPhone = phone;
    final response = await http.post(
      Uri.parse(_startUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'to': phone, 'channel': 'sms'}),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['success'] == true;
    }
    return false;
  }

  static Future<bool> checkVerification(String code) async {
    final response = await http.post(
      Uri.parse(_checkUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'to': _formattedPhone, 'code': code}),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['success'] ?? false;
    }
    return false;
  }
}

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  bool isVerifying = false;
  bool verificationSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text('Verification', style: TextStyle(color: Colors.white)),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isVerifying = true;
                    });
                    bool success = await VerificationService.startVerification(phoneController.text);
                    setState(() {
                      isVerifying = false;
                      verificationSuccess = success;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[900],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Start Verification'),
                ),
                if (isVerifying) const CircularProgressIndicator(),
                if (verificationSuccess)
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      TextField(
                        controller: codeController,
                        decoration: InputDecoration(
                          labelText: 'Verification Code',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isVerifying = true;
                          });
                          bool success = await VerificationService.checkVerification(codeController.text);
                          setState(() {
                            isVerifying = false;
                            verificationSuccess = success;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal[900],
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Check Verification'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: VerificationPage(),
  ));
}
