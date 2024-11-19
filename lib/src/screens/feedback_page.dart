import 'package:final_year_project2024/src/screens/login_page.dart';
import 'package:flutter/material.dart';
import '../models/feedback.dart';
import '../utils/database_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController messageController = TextEditingController();
  int rating = 0;
  final Map<int, String> ratingDescriptions = {
    1: 'Very Bad',
    2: 'Bad',
    3: 'Average',
    4: 'Good',
    5: 'Excellent',
  };

  Future<void> _submitFeedback(int rating) async {
    String userMail = LoginPage.user_email;
    String msg = messageController.text;

    try {

        var response = await http.post(
          Uri.parse("https://lasting-proper-midge.ngrok-free.app/api/feedback/create"),
          headers: {
            'Content-Type': 'application/json',
            "ngrok-skip-browser-warning": "69420",
          },
          body: jsonEncode({
            'email': userMail,
            'message':msg,
            'rating': rating,
          }),
        );

        if (response.statusCode == 200) {


          print('Feedback added successfully');
          Navigator.pushReplacementNamed(context, '/dashboard');

        } else {
          print('Unexpected status code: ${response.statusCode}');
        }




      // DatabaseHelper dbHelper = DatabaseHelper();
      // LocalFeedback feedback = LocalFeedback(
      //   email: userMail,
      //   message: msg,
      //   rating: rating,
      // );
      //
      // await dbHelper.insertFeedback(feedback);


    } catch (e) {
      print('Error adding feedback: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to submit feedback. Please try again later.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Provide Feedback',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFFDF3E7),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Color(0xFFFDF3E7),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0), // Only horizontal padding
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0), // Minimal top padding
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '1. Were you satisfied with the cinnamon quality classification results?\n'
                            '2. How can we improve your experience with Cinnalyze?',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      const SizedBox(height: 1), // Reduced spacing
                      TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: 'Your Answers',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rating: $rating - ${ratingDescriptions[rating] ?? 'Select a rating'}',
                            style: const TextStyle(color: Colors.black),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow[700],
                            size: 24,
                          ),
                        ],
                      ),
                      Slider(
                        value: rating.toDouble(),
                        min: 0,
                        max: 5,
                        divisions: 5,
                        onChanged: (value) {
                          setState(() {
                            rating = value.toInt();
                          });
                        },
                        activeColor: Colors.yellow[700],
                        inactiveColor: Colors.grey[300],
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: OutlinedButton(
                          onPressed: () {
                            _submitFeedback(rating);
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 1, color: Colors.brown),
                            backgroundColor: Colors.brown,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Submit Feedback',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20), // Space between form and additional text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10), // Space between the two additional texts
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft, // Aligns text to the left
                  child: Text(
                    'Contact Us\nContact No: 0765798114\nEmail: ridmirasanjalee63@gmail.com',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Space between form and additional text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Your feedback helps us improve our services and better serve you in the future.',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
