import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  static const String baseUrl = "http://127.0.0.1:8000";

  static Future<Map<String, dynamic>> checkBackend() async {
    final url = Uri.parse("$baseUrl/");
    final response = await http.get(url);
    return jsonDecode(response.body);
  }
}
