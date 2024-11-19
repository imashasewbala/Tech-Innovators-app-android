// lib/src/screens/home_page.dart

import 'package:flutter/material.dart';
import 'login_page.dart';
import 'registration_page.dart';

class HomePage extends StatelessWidget {
  static const Color backgroundColor = Color(0xFFFDF3E7); // Light cream/beige background
  static const Color buttonBorderColor = Color(0xFF8D6E63); // Light brown for the border of the register button
  static const Color submitButtonColor = Color(0xFF6D4C41); // Dark brown for the login button
  static const Color buttonTextColor = Color(0xFF6D4C41); // Dark brown text color for the register button

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // Center Content: Logo
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo (cinnamon.png)
                Image.asset(
                  'assets/images/cinnamon09.png',
                  width: 350, // Adjust width as per your requirement
                  height: 350, // Adjust height as per your requirement
                ),
              ],
            ),
          ),

          // Bottom Positioned Buttons
          Positioned(
            bottom: 40, // Distance from the bottom of the screen
            left: 20, // Left margin for the register button
            right: 20, // Right margin for the login button
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Register Button (OutlinedButton)
                SizedBox(
                  width: 150, // Adjust width for the button
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistrationPage()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: buttonBorderColor, width: 2), // Border color and width
                      padding: EdgeInsets.symmetric(vertical: 14), // Adjust vertical padding for the button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // No rounded corners
                      ),
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: buttonTextColor, // Dark brown text color
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                // Login Button (ElevatedButton)
                SizedBox(
                  width: 150, // Adjust width for the button
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: submitButtonColor, // Solid dark brown color
                      padding: EdgeInsets.symmetric(vertical: 14), // Adjust vertical padding for the button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // No rounded corners
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white, // White text color
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



