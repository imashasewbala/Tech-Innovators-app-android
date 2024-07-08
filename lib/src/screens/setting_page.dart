import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _notificationsEnabled = false;
  bool _dontSaveHistory = false;
  bool _weeklyReportEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Settings', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.teal[200]!, Colors.teal[900]!],
          ),
        ),
        child: ListView(
          children: [
            SwitchListTile(
              title: Text('Enable Notifications'),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                  _updateSetting('notifications', value);
                });
              },
              secondary: Icon(Icons.notifications_active, color: Colors.teal[100]),
            ),
            SwitchListTile(
              title: Text('Don\'t Save My History'),
              value: _dontSaveHistory,
              onChanged: (bool value) {
                setState(() {
                  _dontSaveHistory = value;
                  _updateSetting('dontSaveHistory', value);
                });
              },
              secondary: Icon(Icons.history_toggle_off, color: Colors.teal[100]),
            ),
            SwitchListTile(
              title: Text('Weekly Report on My Crops'),
              value: _weeklyReportEnabled,
              onChanged: (bool value) {
                setState(() {
                  _weeklyReportEnabled = value;
                  _updateSetting('weeklyReport', value);
                });
              },
              secondary: Icon(Icons.report, color: Colors.teal[100]),
            ),
          ],
        ),
      ),
    );
  }
}
