import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api.example.com';

  static Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Map<String, dynamic>> getExchangeRates() async {
    try {
      final response = await http.get(
        Uri.parse('https://open.er-api.com/v6/latest/USD'),
      );
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Map<String, dynamic>> post(
      String endpoint, dynamic body) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    final Map<String, dynamic> responseBody = json.decode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return responseBody;
    } else {
      throw ApiException(
        message: responseBody['message'] ?? 'Something went wrong',
        statusCode: response.statusCode,
      );
    }
  }

  static Map<String, dynamic> _handleError(dynamic error) {
    if (error is ApiException) {
      throw error;
    } else {
      throw ApiException(message: 'Something went wrong', statusCode: null);
    }
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, required this.statusCode});

  @override
  String toString() {
    return 'ApiException: $message, statusCode: $statusCode';
  }
}
