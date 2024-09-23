import 'dart:convert';
import 'package:http/http.dart' as http;


class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<dynamic> getRequest(String endpoint) async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      return _processResponse(response);
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
  static Future<List<dynamic>> getData(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse['items']; // Extract the list from 'items'
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Future<dynamic> postRequest( Map<String, dynamic> data) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse(baseUrl),
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode(data),
  //     );
  //     return _processResponse(response);
  //   } catch (e) {
  //     throw Exception('Failed to post data: $e');
  //   }
  // }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 400:
        throw Exception('Bad request');
      case 401:
      case 403:
        throw Exception('Unauthorized');
      case 500:
      default:
        throw Exception('Server error: ${response.statusCode}');
    }
  }
}
