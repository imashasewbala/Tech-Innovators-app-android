import 'dart:convert';
import 'package:http/http.dart' as http;

class DatabaseCheck {
  final String _baseUrl = "http://192.168.43.170/api_cinnalyze/";  // Ensure the URL ends with '/'

  Future<bool> authenticateUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('${_baseUrl}login.php'),
      body: {
        'email': email,
        'password': password,
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData['status'];
    } else {
      throw Exception('Failed to authenticate user');
    }
  }

  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('${_baseUrl}login.php'),
      body: {
        'email': email,
        'password': password,
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status']) {
        return responseData['user'];
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to fetch user');
    }
  }

  Future<bool> submitFeedback(String email, String message, int rating) async {
    final response = await http.post(
      Uri.parse('${_baseUrl}submit_feedback.php'),
      body: {
        'email': email,
        'message': message,
        'rating': rating.toString(),
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData['status'];
    } else {
      throw Exception('Failed to submit feedback');
    }
  }
}

