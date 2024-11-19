import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/feedback.dart'; // Ensure the correct path

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  final String _baseUrl = 'http://192.168.43.170/api_cinnalyze'; // Replace with your server path

  Future<void> _handleRequest(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$_baseUrl$endpoint'),
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    final responseBody = jsonDecode(response.body);
    if (!responseBody['success']) {
      throw Exception(responseBody['message']);
    }
  }

  Future<void> insertUser(User user) async {
    try {
      final body = user.toMap(); // Assuming User has a toMap method
      await _handleRequest('register.php', body);
    } catch (e) {
      print('Error inserting user: $e');
      rethrow;
    }
  }

  Future<void> updateUser(User user) async {
    try {
      final body = user.toMap(); // Assuming User has a toMap method
      await _handleRequest('update_user.php', body);
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }

  Future<int> getCount() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/user_count.php'));
      final responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        return responseBody['count'];
      } else {
        throw Exception(responseBody['message']);
      }
    } catch (e) {
      print('Error getting user count: $e');
      rethrow;
    }
  }

  Future<User?> getUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/get_user.php'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );
      final responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        return User.fromMap(responseBody['user']); // Adjust based on actual response structure
      } else {
        throw Exception(responseBody['message']);
      }
    } catch (e) {
      print('Error getting user: $e');
      rethrow;
    }
  }

  Future<bool> authenticateUser(String email, String password) async {
    final user = await getUser(email, password);
    return user != null;
  }

  Future<bool> resetPassword(String email, String newPassword) async {
    try {
      await _handleRequest('reset_password.php', {'email': email, 'new_password': newPassword});
      return true;
    } catch (e) {
      print('Error resetting password: $e');
      return false;
    }
  }

  Future<void> insertFeedback(LocalFeedback feedback) async {
    try {
      final body = feedback.toMap(); // Assuming LocalFeedback has a toMap method
      await _handleRequest('insert_feedback.php', body);
    } catch (e) {
      print('Error inserting feedback: $e');
      rethrow;
    }
  }
}


