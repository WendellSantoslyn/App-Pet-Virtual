import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserService {
  final String baseUrl = "http://127.0.0.1:8000/users";

  Future<UserModel> createUser(String login, String senha) async {
    final url = Uri.parse("$baseUrl/");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "login": login,
        "senha": senha,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data); // <--- CORRETO
    } else {
      throw Exception("Erro ao criar usuário: ${response.body}");
    }
  }

  Future<UserModel> loginUser(String login, String senha) async {
  final url = Uri.parse("$baseUrl/login");

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "login": login,
      "senha": senha,
    }),
  );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else if (response.statusCode == 401) {
      throw Exception("Credenciais inválidas");
    } else {
      throw Exception("Erro no login: ${response.body}");
    }
  }

}
