import 'package:final_year_project2024/src/screens/login_page.dart';
import 'package:flutter/material.dart';
import '../models/feedback.dart'; // Ensure the correct path
import '../utils/database_helper.dart'; // Ensure the correct path
import 'package:http/http.dart' as http; // Import http package for making HTTP requests

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
    5: 'Very Good',
  };

  // void _submitFeedback(BuildContext context) async {
  //   if (messageController.text.isNotEmpty && rating > 0) {
  //     LocalFeedback feedback = LocalFeedback(
  //       // id: 1, // Replace with actual ID generation logic if needed
  //       message: messageController.text,
  //       rating: rating,
  //     );
  //
  //     try {
  //       DatabaseHelper dbHelper = DatabaseHelper();
  //       int result = await dbHelper.insertFeedback(feedback);
  //
  //       if (result > 0) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('Thank you for your feedback!'),
  //           ),
  //         );
  //
  //         // Clear form fields after submission
  //         messageController.clear();
  //         setState(() {
  //           rating = 0;
  //         });
  //
  //         // Navigate back to home page after feedback submission
  //         Navigator.pushReplacementNamed(context, '/home');
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('Failed to submit feedback. Please try again.'),
  //           ),
  //         );
  //       }
  //     } catch (e) {
  //       print('Error inserting feedback: $e');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Failed to submit feedback. Please try again.'),
  //         ),
  //       );
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Please fill in all fields.'),
  //       ),
  //     );
  //   }
  // }

  // Function to authenticate user using MongoDB API
  Future<void> _submitFeedback(int rating) async {
    String userMail = LoginPage.user_email;
    String msg = messageController.text;
    String apiUrl = 'https://ap-south-1.aws.data.mongodb-api.com/app/application-0-ltlkiua/endpoint/api/feedback';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    String requestBody = '{"email": "$userMail", "message": "$msg","rating":"$rating"}';

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 201) {
        // Successfully authenticated
        // You can parse the response data here if needed
        print('Feddback added: ${response.body}');
        Navigator.pushReplacementNamed(context, '/dashboard');

      } else {
        // Handle feeback failure
        print('beedback failed: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('feedback failed. Please check your fields.'),
          ),
        );
      }
    } catch (e) {
      print('Error authenticating user: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to authenticate user. Please try again later.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provide Feedback'),
        backgroundColor: Colors.teal[900],
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
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    labelText: 'Feedback',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 20),
                Text('Rating: $rating - ${ratingDescriptions[rating] ?? 'Select a rating'}'),
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
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Authenticate user before submitting feedback
                    // _authenticateUser('jane.doe@example.com', 'securepassword1234');
                    // _submitFeedback(context);
                    _submitFeedback(rating);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[900],
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Submit Feedback'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
