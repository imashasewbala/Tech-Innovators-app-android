import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class SettingPage extends StatefulWidget {
  final Function() onSettingsChanged;

  SettingPage({Key? key, required this.onSettingsChanged}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _notificationsEnabled = false;
  bool _dontSaveHistory = false;
  bool _weeklyReportEnabled = false;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _initNotifications();
  }

  Future<void> _initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications') ?? false;
      _dontSaveHistory = prefs.getBool('dontSaveHistory') ?? false;
      _weeklyReportEnabled = prefs.getBool('weeklyReport') ?? false;
    });
  }

  Future<void> _updateSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);

    // Prepare the data for the POST request
    Map<String, dynamic> data = {
      'user_id': 1, // Replace with your actual user ID handling logic
      'notifications_enabled': value,
    };

    // Make the POST request to update notifications setting
    try {
      final response = await http.post(
        Uri.parse('https://your-backend-url/api/enable_notifications'), // Replace with your actual backend URL
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print('Notification setting updated successfully');
      } else {
        print('Failed to update notification setting');
      }
    } catch (e) {
      print('Error updating notification setting: $e');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFDF3E7), // Changed to brown
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFFDF3E7), // Beige background color
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Image.asset(
                  'assets/images/cinnamon6.png',
                  width: 200, // Adjust the size as needed
                  height: 200,
                ),
              ),
            ),
            SwitchListTile(
              title: const Text(
                'Enable Notifications',
                style: TextStyle(color: Colors.brown), // Changed to brown
              ),
              value: _notificationsEnabled,
              onChanged: (bool value) => _updateSetting('notifications', value),
              secondary: Icon(Icons.notifications_active, color: Colors.brown), // Changed to brown
            ),
            SwitchListTile(
              title: const Text(
                'Don\'t Save My History',
                style: TextStyle(color: Colors.brown), // Changed to brown
              ),
              value: _dontSaveHistory,
              onChanged: (bool value) => _updateSetting('dontSaveHistory', value),
              secondary: Icon(Icons.history_toggle_off, color: Colors.brown), // Changed to brown
            ),
            SwitchListTile(
              title: const Text(
                'Remove Weekly Report on My Crops',
                style: TextStyle(color: Colors.brown), // Changed to brown
              ),
              value: _weeklyReportEnabled,
              onChanged: (bool value) => _updateSetting('weeklyReport', value),
              secondary: Icon(Icons.report, color: Colors.brown), // Changed to brown
            ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: 60, // Adjust width as desired
          height: 40, // Adjust height as desired
          child: OutlinedButton(
            onPressed: () {
              widget.onSettingsChanged(); // Notify the home screen to update its UI
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Changes Applied"),
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.brown, // Changed to brown
                ),
              );
              Navigator.pop(context); // Go back to the home screen
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(width: 1, color: Colors.brown),
              backgroundColor: Colors.brown,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Reduced padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: Size(150, 40),
            ),
                child: const Text(
                  'Apply Changes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
      ),
          ],
        ),
      ),
    );
  }
}
