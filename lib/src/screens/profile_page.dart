import 'package:final_year_project2024/src/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFDF3E7),
        title: const Text('', style: TextStyle(color: Colors.brown)),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFFFDF3E7), Color(0xFFFDF3E7)], // Different colors for gradient
          ),
        ),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                child: Text(
                  '${LoginPage.user_first_name} ${LoginPage.user_last_name}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.brown),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _image == null
                          ? AssetImage('images/profile.png')
                          : FileImage(_image!) as ImageProvider,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(height: 20), // Space between CircleAvatar and buttons
                    ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.camera),
                      icon: Icon(Icons.camera_alt),
                      label: Text(''),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFDF3E7),
                        foregroundColor: Colors.brown,
                      ),
                    ),
                    SizedBox(height: 10), // Space between buttons
                    ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: Icon(Icons.photo),
                      label: Text(''),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFDF3E7),
                        foregroundColor: Colors.brown,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.email, color: Colors.brown),
                      title: Text('Email', style: TextStyle(color: Colors.brown)),
                      subtitle: Text(LoginPage.user_email, style: TextStyle(color: Colors.brown)),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone, color: Colors.brown),
                      title: Text('Phone', style: TextStyle(color: Colors.brown)),
                      subtitle: Text(LoginPage.user_phone, style: TextStyle(color: Colors.brown)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}