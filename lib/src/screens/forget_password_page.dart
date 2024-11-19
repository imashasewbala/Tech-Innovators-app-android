import 'package:flutter/material.dart';
import 'package:final_year_project2024/src/utils/database_helper.dart'; // Import your database helper
import 'package:final_year_project2024/src/screens/login_page.dart'; // Import your login page
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordResetSuccess = false;
  String _errorMessage = ''; // Error message
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        setState(() {
          _errorMessage = 'Passwords do not match';
        });
        return;
      }


      bool passwordUpdated = false;
      try {

        var response = await http.post(
          Uri.parse("https://lasting-proper-midge.ngrok-free.app/api/users/update-password"),
          headers: {
            'Content-Type': 'application/json',
            "ngrok-skip-browser-warning": "69420",
          },
          body: jsonEncode({
            'email': _emailController.text,
            'newPassword':_passwordController.text,
          }),
        );

        if (response.statusCode == 200) {

          passwordUpdated = true;

        } else {
          print('Unexpected status code: ${response.statusCode}');
        }

      } catch (e) {
        print('Error changing password: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to submit feedback. Please try again later.'),
          ),
        );
      }






      if (passwordUpdated) {
        setState(() {
          _passwordResetSuccess = true;
        });

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Password Reset Successful'),
            content: Text('Your new password is saved successfully.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.pushReplacementNamed(context, '/login'); // Navigate to login page
                },
              ),
            ],
          ),
        );
      } else {
        setState(() {
          _errorMessage = 'Failed to update password. Please try again.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFDF3E7),
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFDF3E7),
              Color(0xFFFDF3E7),
            ],
          ),
        ),

    child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
    children: [
    Text(
    'Reset Your Password',
    style: TextStyle(color: Colors.black, fontSize: 24),
    ),
    SizedBox(height: 8),
    Text(
    "Don't worry, we've got you covered",
    style: TextStyle(color: Colors.black, fontSize: 14),
    ),

        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 10),
                _buildTextField('Email', _emailController, Icons.email),
                SizedBox(height: 20),
                _buildTextField('New Password', _passwordController, Icons.lock, obscureText: true, isPassword: true),
                SizedBox(height: 20),
                _buildTextField('Confirm Password', _confirmPasswordController, Icons.lock, obscureText: true, isPassword: true, isConfirmPassword: true),

                SizedBox(height: 20),
                SizedBox(height: 20),
                Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.brown,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _resetPassword,
                  child: Text('Reset Password',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                ),
              ],
            ),
          ),
        ),
    ],
      ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller, IconData icon, {bool obscureText = false, bool isPassword = false, bool isConfirmPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? (!_passwordVisible) : isConfirmPassword ? (!_confirmPasswordVisible) : obscureText,
      decoration: InputDecoration(
        labelText: labelText,

        suffixIcon: isPassword || isConfirmPassword
            ? IconButton(
          icon: Icon(
            isPassword
                ? (_passwordVisible ? Icons.visibility : Icons.visibility_off)
                : (_confirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              if (isPassword) {
                _passwordVisible = !_passwordVisible;
              } else if (isConfirmPassword) {
                _confirmPasswordVisible = !_confirmPasswordVisible;
              }
            });
          },
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
        filled: true,
        fillColor: Colors.transparent,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
    );
  }
}
