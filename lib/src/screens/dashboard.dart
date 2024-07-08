import 'package:final_year_project2024/src/screens/home_page.dart';
import 'package:final_year_project2024/src/screens/view_past_data.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project2024/src/screens/login_page.dart';
import 'package:final_year_project2024/src/screens/profile_page.dart';
import 'package:final_year_project2024/src/screens/setting_page.dart';
import 'package:final_year_project2024/src/screens/upload_image.dart';
import 'package:final_year_project2024/src/screens/feedback_page.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Home \nSelect an option', style: TextStyle(color: Colors.white)),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.person, size: 30, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
              // Navigate to user profile screen (implement this)
            },
          ),
        ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50),
              SizedBox(height: 30),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildHomeButton(context, Icons.cloud_upload, "Upload an image"),
                    _buildHomeButton(context, Icons.history, "View past data"),
                    _buildHomeButton(context, Icons.settings, "Settings"),
                    _buildHomeButton(context, Icons.exit_to_app, "Logout"),
                    _buildHomeButton(context, Icons.feedback, "Feedback"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeButton(BuildContext context, IconData icon, String label) {
    return Card(
      color: Colors.white.withOpacity(0.9),
      child: InkWell(
        onTap: () => _handleNavigation(context, label),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 40, color: Colors.teal),
            Text(label, style: TextStyle(color: Colors.teal)),
          ],
        ),
      ),
    );
  }

  void _handleNavigation(BuildContext context, String label) {
    switch (label) {
      case "Upload an image":
        Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImage()));
        break;
      case "View past data":
        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPastData()));
        break;
      case "Settings":
        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage()));
        break;
      case "Logout":
        _showLogoutDialog(context);
        break;
      case "Feedback":
        Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage()));
        break;
      default:
        break;
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Logged out successfully"),
                  ),
                );// Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                ); // Navigate to login page
              },
              child: Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}
