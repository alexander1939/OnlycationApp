import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../core/constants/app_constants.dart';

class ApiService {
  final String baseUrl = AppConstants.baseUrl;
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Add token to headers if needed
  void setAuthToken(String token) {
    _headers['Authorization'] = 'Bearer $token';
  }

  // Generic GET request
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  // Generic POST request
  Future<dynamic> post(String endpoint, {dynamic body}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  // Handle API response
  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw Exception('Bad Request: ${response.body}');
      case 401:
      case 403:
        throw Exception('Unauthorized: ${response.body}');
      case 500:
      default:
        throw Exception(
          'Error occurred while communicating with server. StatusCode: ${response.statusCode}');
    }
  }
}
