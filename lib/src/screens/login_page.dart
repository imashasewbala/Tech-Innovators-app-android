import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  static String user_first_name = "";
  static String user_last_name = "";
  static String user_email = "";
  static String user_password = "";
  static String user_phone = "";
  static String user_date = "";

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Failed'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Future<void> _userLogin(String email, String password) async {
    print('Attempting to log in with Email: $email and Password: $password');
    try {
      var response = await http.post(
        Uri.parse("https://lasting-proper-midge.ngrok-free.app/api/users/login"), // Replace with your actual API endpoint
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      try {
        var responseBody = jsonDecode(response.body);
        print('Parsed Response Body: $responseBody');

        if (response.statusCode == 200 && responseBody['status'] == 'success') {
          LoginPage.user_first_name = responseBody['user']['firstName'];
          LoginPage.user_last_name = responseBody['user']['lastName'];
          LoginPage.user_email = responseBody['user']['email'];
          LoginPage.user_phone = responseBody['user']['phoneNumber'];

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Successfully logged in')),
          );

          // Navigate to the dashboard if login is successful
          print('Login Successful, navigating to dashboard...');
          Navigator.pushReplacementNamed(context, '/dashboard');
        } else {
          // Failure in response body status
          print('Login failed');
          _showErrorDialog(responseBody['message'] ?? 'Login failed.');
        }
      } catch (e) {
        print('Error parsing response body: $e');
        _showErrorDialog('An error occurred. Please try again.');
      }
    } catch (e) {
      print('Error: $e');
      _showErrorDialog('An error occurred while trying to log in.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFDF3E7),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('', style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFF9F2E7),
                  Color(0xFFFDF3E7),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text('Sign in', style: TextStyle(color: Colors.black, fontSize: 24)),
                  SizedBox(height: 8),
                  Text('Please provide your details', style: TextStyle(color: Colors.black, fontSize: 14)),
                  SizedBox(height: 50),
                  _buildTextField("Enter Your Email Address", controller: _usernameController),
                  SizedBox(height: 20),
                  _buildPasswordField(_passwordController, "Password", Icons.lock, _passwordVisible),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgot_password');
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: "Forgot Your", style: TextStyle(fontSize: 16, color: Colors.black)),
                            TextSpan(
                              text: ' Password?',
                              style: TextStyle(fontSize: 16, color: Colors.brown, decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: Size(0, 0),
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _userLogin(_usernameController.text, _passwordController.text);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill in all fields')));
                      }
                    },
                    child: SizedBox(
                      height: 50,
                      width: 200,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 1, color: Colors.brown),
                          backgroundColor: Colors.brown,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Sign in', style: TextStyle(fontSize: 16, color: Colors.white)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _userLogin(_usernameController.text, _passwordController.text);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill in all fields')));
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/registration');
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: "Don't have an account?", style: TextStyle(fontSize: 16, color: Colors.black)),
                            TextSpan(
                              text: '  Register',
                              style: TextStyle(fontSize: 16, color: Colors.brown, decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: Size(0, 0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String labelText, {required TextEditingController controller}) {
    return SizedBox(
      width: 400,
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black, fontSize: 14),
          fillColor: Colors.transparent,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            print('Validation failed for $labelText');
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String labelText, IconData icon, bool obscureText) {
    return SizedBox(
      width: 400,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black, fontSize: 14),
          fillColor: Colors.transparent,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
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
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            print('Validation failed for $labelText');
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }
}
