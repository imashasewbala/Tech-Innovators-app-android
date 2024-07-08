/*import 'package:flutter/material.dart';
import 'package:final_year_project2024/src/utils/database_helper.dart';

class VerificationPage extends StatefulWidget {
  final String phoneNumber;

  const VerificationPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController verificationCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _verifyCode() async {
    if (_formKey.currentState!.validate()) {
      DatabaseHelper dbHelper = DatabaseHelper();
      Map<String, dynamic>? codeDetails = await dbHelper.getVerificationCode(
        widget.phoneNumber,
        verificationCodeController.text,
      );
      if (codeDetails != null) {
        await dbHelper.updateUserVerificationStatus(widget.phoneNumber, 1); // Mark user as verified
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Verification successful')),
        );
        // Navigate to login page or home page
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid verification code')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Enter the verification code sent to ${widget.phoneNumber}',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                controller: verificationCodeController,
                decoration: InputDecoration(labelText: 'Verification Code'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter verification code';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _verifyCode,
                child: Text('Verify'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/