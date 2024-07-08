import 'package:flutter/material.dart';
import 'package:final_year_project2024/src/utils/database_helper.dart';
import 'package:final_year_project2024/src/models/user.dart';
import 'package:http/http.dart' as http; // Import http package for making HTTP requests
import 'dart:convert';


class LoginPage extends StatefulWidget {

  static String user_first_name = "";
  static String user_last_name = "";
  static String user_email = "";
  static String user_password = "";
  static String user_phone ="";
  static String user_date="";


  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late DatabaseHelper dbHelper;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper(); // Initialize DatabaseHelper in initState
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      bool isAuthenticated = await dbHelper.authenticateUser(
        _usernameController.text,
        _passwordController.text,
      );
      if (isAuthenticated) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        _showErrorDialog('Invalid username or password.');
      }
    }
  }

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

  // Function to fetch user information from MongoDB API
  Future<void> _getUserInfo(String email) async {
    String apiUrl = 'https://ap-south-1.aws.data.mongodb-api.com/app/application-0-ltlkiua/endpoint/api/getuser';
    String queryParams = '?email=$email';

    try {
      var response = await http.get(Uri.parse(apiUrl + queryParams));

      if (response.statusCode == 200) {
        // Successfully fetched user info
        // You can parse the response data here if needed
        // print('User Info: ${response.body}');
      } else {
        // Handle errors
        print('Failed to fetch user info: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user info: $e');
    }
  }

  Future<void> _userLogin(String email, String password) async {
    String apiUrl = 'https://ap-south-1.aws.data.mongodb-api.com/app/application-0-ltlkiua/endpoint/api/login';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);

      if (response.statusCode == 200) {
        // Successfully fetched user info
        // You can parse the response data here if needed
        print('User Info: ${response.body}');
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        LoginPage.user_first_name = jsonResponse['data']['first_name'];
        LoginPage.user_last_name = jsonResponse['data']['last_name'];
        LoginPage.user_email = jsonResponse['data']['email'];
        LoginPage.user_phone = jsonResponse['data']['phone'];
        LoginPage.user_date = jsonResponse['data']['date'];

        Navigator.pushReplacementNamed(context, '/dashboard');

      } else {
        // Handle errors
        _showErrorDialog('Invalid username or password.');

        print('Failed to fetch user info: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(
              'Get started on your journey',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal[300]!,
              Colors.teal[500]!,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                _buildTextField("Enter your email", Icons.person),
                const SizedBox(height: 10),
                _buildTextField("Enter your password", Icons.lock, obscureText: true),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot_password');
                  },
                  child: const Text("Forgot password?", style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  child: const Text('Login'),
                  onPressed: () {
                    _userLogin(_usernameController.text, _passwordController.text);
                    // _getUserInfo(_usernameController.text); // Call _getUserInfo when logging in
                  },
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/registration');
                  },
                  child: const Text("Don't have an account? Register", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, IconData icon, {bool obscureText = false}) {
    return TextFormField(
      controller: obscureText ? _passwordController : _usernameController,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
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
