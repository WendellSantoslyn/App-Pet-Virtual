import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static const base = "http://127.0.0.1:8000";
  static String userId = "";

  static Future<Map<String, dynamic>?> getPet(String userId) async {
    final res = await http.get(Uri.parse("$base/pet/$userId"));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }

    if (res.statusCode == 404) {
      return null;
    }

    throw Exception("Erro ao consultar pet");
  }

  static Future<bool> createPet(String userId, String name, String color) async {
    final res = await http.post(
      Uri.parse("$base/pet/$userId"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "color": color,
      }),
    );

    return res.statusCode == 200;
  }
}
