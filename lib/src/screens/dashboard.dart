import 'package:flutter/material.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'view_past_data.dart';
import 'feedback_page.dart';
import 'help_page.dart';
import 'setting_page.dart';
import 'webview_screen.dart';
import 'upload_image.dart'; // Import the UploadImage screen

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFFDF3E7), // Beige background color
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  const SizedBox(height: 60),
                  // Top Image (Stretches across the screen width)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0), // Rounded corners
                        border: Border.all(color: Color(0xFFD2B48C), width: 2.0), // Light brown border
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), // Shadow color
                            spreadRadius: 2, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset: Offset(0, 3), // Changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0), // Optional rounded corners for the image
                        child: Image.asset(
                          'assets/images/cin.jpg', // Image named abc.jpg
                          width: double.infinity, // Stretches to cover the full width
                          height: 250, // Increased height
                          fit: BoxFit.cover, // Ensures the image fills the area nicely
                        ),
                      ),
                    ),
                  ),
                  // Top Divider Line (slightly darker than beige)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    color: const Color(0xFFE0DCC6), // Slightly darker than beige
                    height: 1,
                  ),
                  // Adding space to move the buttons further down
                  const SizedBox(height: 30),
                  // Buttons Grid (3 per row)
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 20), // Space before the button grid
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 3, // 3 buttons per row
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            children: [
                              _buildHomeButton(context, Icons.help, "Help & FAQs"),
                              _buildHomeButton(context, Icons.monetization_on, "Market Price"),
                              _buildHomeButton(context, Icons.history, "View Past Data"),
                              _buildHomeButton(context, Icons.feedback, "Feedback"),
                              _buildHomeButton(context, Icons.settings, "Settings"),
                              _buildHomeButton(context, Icons.exit_to_app, "Logout"),
                            ],
                          ),
                        ),
                        // Extra spacing before the bottom divider line
                        const SizedBox(height: 20),
                        // Bottom Divider Line (slightly darker than beige)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          color: const Color(0xFFE0DCC6), // Slightly darker than beige
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                  // Main Button ("Check Quality") - Navigates to UploadImage screen
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0), // Move "Check Quality" button slightly up
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to UploadImage when "Check Quality" button is pressed
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UploadImage()), // Navigates to UploadImage screen
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown, // Highlighted brown button
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16), // Rectangular shape
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Rounded rectangle shape
                        ),
                      ),
                      child: const Text(
                        'Check Quality',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white, // White text
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Top-right corner button
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  icon: Icon(Icons.person, color: Colors.brown, size:40), // Icon color
                  onPressed: () {
                    // Navigate to ProfilePage or any other screen when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()), // Replace with the page you want to navigate to
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Home Button Widget for the Grid
  Widget _buildHomeButton(BuildContext context, IconData icon, String label) {
    return Card(
      color: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Color(0xFFD2B48C), width: 1.0),
      ),
      child: InkWell(
        onTap: () => _handleNavigation(context, label),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 40, color: Colors.brown), // Icons in brown
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: Colors.brown)), // Text in brown
          ],
        ),
      ),
    );
  }

  // Navigation Handler
  void _handleNavigation(BuildContext context, String label) {
    switch (label) {
      case "Market Price": // Navigate to WebViewScreen for "Market Price"
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(url: 'https://exagri.info/mkt/index.html'), // Add your URL here
          ),
        );
        break;
      case "View Past Data":
        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPastData()));
        break;
      case "Settings":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SettingPage(
              onSettingsChanged: () {
                // Implement what needs to happen when settings are changed
              },
            ),
          ),
        );
        break;
      case "Help & FAQs":
        Navigator.push(context, MaterialPageRoute(builder: (context) => HelpPage()));
        break;
      case "Feedback":
        Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage()));
        break;
      case "Logout":
        _showLogoutDialog(context);
        break;
      default:
        break;
    }
  }

  // Logout Confirmation Dialog
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
                  SnackBar(content: Text("Logged out successfully")),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}
