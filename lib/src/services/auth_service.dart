/*import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "http://yourapiurl.com/api/v1/auth"; // Change to your actual API URL

  Future<String?> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/forgot-password'),
      body: {'email': email},
    );

    if (response.statusCode == 200) {
      return null;
    } else {
      print('Failed to send forgot password email: ${response.body}');
      return response.body;
    }
  }

  Future<String?> resetPassword(String email, String code, String newPassword) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reset-password'),
      body: {
        'email': email,
        'code': code,
        'password': newPassword,*/
      /*},
    );

    if (response.statusCode == 200) {
      return null;
    } else {
      print('Failed to reset password: ${response.body}');
      return response.body;
    }
  }
}*/
