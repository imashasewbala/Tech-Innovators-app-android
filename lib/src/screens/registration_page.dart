import 'package:flutter/material.dart';
import 'package:final_year_project2024/src/utils/database_helper.dart';
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

  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _registrationSuccess = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
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
        isVerified: 0, // Initial state of isVerified
      );

      try {
        DatabaseHelper dbHelper = DatabaseHelper();
        // await dbHelper.insertUser(user);
        RegistrationPage.OTP_Phone = user.phoneNumber;
        await _registerUserApi(user);  // Call the API registration method
        setState(() {
          _registrationSuccess = true;
        });
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => StartVerificationPage()),
          );
        });
      } catch (e) {
        print('Error registering user: $e');
      }
    }
  }

  Future<void> _registerUserApi(User user) async {
    DateTime now = DateTime.now();
    int day = now.day;
    int month = now.month;
    int year = now.year;

    String currentDate = '$day:$month:$year';
    const url = 'https://ap-south-1.aws.data.mongodb-api.com/app/application-0-ltlkiua/endpoint/api/register';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'first_name': user.firstName,
      'last_name': user.lastName,
      'email': user.email,
      'phone': user.phoneNumber,
      'password': user.password,
      'date':currentDate,
    });

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        print('User registered successfully');
      } else {
        print('Failed to register user: ${response.body}');
      }
    } catch (e) {
      print('Error during registration API call: $e');
    }
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

  Future<void> _showResetConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to dismiss
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Register', style: TextStyle(color: Colors.white)),
        elevation: 0,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.teal[300]!,
              Colors.teal[800]!,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 15),
                _buildTextField(firstNameController, "First Name", Icons.person,
                    firstNameFocusNode),
                _buildTextField(
                    lastNameController, "Last Name", Icons.person_outline,
                    lastNameFocusNode),
                _buildTextField(emailController, "Email Address", Icons.email,
                    emailFocusNode, validateEmail: true),
                _buildTextField(
                    phoneNumberController, "Phone Number", Icons.phone,
                    phoneNumberFocusNode),
                _buildPasswordField(
                    passwordController, "Password", passwordFocusNode),
                _buildPasswordField(
                    confirmPasswordController, "Confirm Password",
                    confirmPasswordFocusNode, confirm: true),

                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.teal[900],
                        padding: EdgeInsets.symmetric(
                            horizontal: 40, vertical: 12),
                      ),
                      child: Text('Submit'),
                      onPressed: _registerUser,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red[900],
                        padding: EdgeInsets.symmetric(
                            horizontal: 40, vertical: 12),
                      ),
                      child: Text('Reset'),
                      onPressed: _showResetConfirmationDialog,
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

  Widget _buildTextField(TextEditingController controller, String label,
      IconData icon, FocusNode focusNode, {bool validateEmail = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: controller.text.isEmpty ? label : "",
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(icon, color: Colors.teal),
        ),
        validator: (value) {
          if (value!.isEmpty) return 'Please enter $label';
          if (validateEmail &&
              !RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
            return 'Enter a valid email address';
          }
          return null;
        },
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label,
      FocusNode focusNode, {bool confirm = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: controller.text.isEmpty ? label : "",
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(Icons.lock, color: Colors.teal),
        ),
        validator: (value) {
          if (value!.isEmpty) return 'Please enter $label';
          if (label == "Password" && value.length < 8)
            return 'Password must be at least 8 characters long';
          if (confirm && value != passwordController.text)
            return 'Passwords do not match';
          return null;
        },
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }
}
