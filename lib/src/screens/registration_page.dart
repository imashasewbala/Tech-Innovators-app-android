import 'package:flutter/material.dart';
import 'package:final_year_project2024/src/models/user.dart';
import 'package:final_year_project2024/src/screens/start_verification_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrationPage extends StatefulWidget {
  static String OTP_Phone = "";

  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      User user = User(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        password: passwordController.text,
        isVerified: false,
      );

      try {
        var response = await http.post(
          Uri.parse("https://lasting-proper-midge.ngrok-free.app/api/users/register"),
          headers: {
            'Content-Type': 'application/json',
            "ngrok-skip-browser-warning": "69420",
          },
          body: jsonEncode({
            'first_name': user.firstName,
            'last_name': user.lastName,
            'email': user.email,
            'phone_number': user.phoneNumber,
            'password': user.password,
          }),
        );

        if (response.statusCode == 200) {


            print('Registration successful, navigating to verification page...');
            RegistrationPage.OTP_Phone = user.phoneNumber;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => StartVerificationPage(email:user.email)),
            );

        } else {
          print('Unexpected status code: ${response.statusCode}');
          _showErrorMessage('Registration failed');
        }
      } catch (e) {
        print('Error registering user: $e');
        _showErrorMessage('An error occurred during registration. Please try again.');
      }
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _showResetConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Reset'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to reset the form?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
                _resetForm();
              },
            ),
          ],
        );
      },
    );
  }

  void _resetForm() {
    setState(() {
      firstNameController.clear();
      lastNameController.clear();
      emailController.clear();
      phoneNumberController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Form has been reset')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('', style: TextStyle(color: Colors.white)),
        elevation: 0,
        backgroundColor: Color(0xFFFDF3E7),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFFDF3E7),
              Color(0xFFFDF3E7),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('User Details', style: TextStyle(fontSize: 24)),
                Text('Provide your personal details to ', style: TextStyle(fontSize: 14)),
                Text('create your account', style: TextStyle(fontSize: 14)),
                SizedBox(height: 50),
                _buildTextField(firstNameController, "First Name", Icons.person),
                _buildTextField(lastNameController, "Last Name", Icons.person_outline),
                _buildTextField(emailController, "Email Address", Icons.email, validateEmail: true),
                _buildTextField(phoneNumberController, "Phone Number", Icons.phone),
                _buildPasswordField(passwordController, "Password"),
                _buildPasswordField(confirmPasswordController, "Confirm Password", confirm: true),

                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 1, color: Colors.black),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                      child: Text('Reset'),
                      onPressed: _showResetConfirmationDialog,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 1, color: Colors.black),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.brown,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                      child: Text('Submit'),
                      onPressed: _registerUser,
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

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool validateEmail = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black, fontSize: 14),
          fillColor: Colors.transparent,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) return 'Please enter $label';
          if (validateEmail && !RegExp(r'^[^@]+@gmail\.com$').hasMatch(value)) {
            return 'Your email format is not valid. Only @gmail.com emails are allowed';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label, {bool confirm = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: !_passwordVisible,
        style: TextStyle(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black, fontSize: 14),
          fillColor: Colors.transparent,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) return 'Please enter $label';
          if (!confirm && (value.length < 8 || !RegExp(r'[a-zA-Z]').hasMatch(value) || !RegExp(r'[0-9]').hasMatch(value))) {
            return 'Password must be at least 8 characters long and contain both letters and numbers';
          }
          if (confirm && value != passwordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }
}
