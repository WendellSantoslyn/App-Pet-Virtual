import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  // Se estiver testando no Android emulator use 10.0.2.2:8000
  // final String host = "http://10.0.2.2:8000"; // para emulador
  static const String base = "http://127.0.0.1:8000"; // para desktop/same-host
  static String userId = "";

  // criar pet -> chama POST /pet/ com usuario_id, nome, cor
  static Future<bool> createPet(String usuarioId, String nome, String cor) async {
    final url = Uri.parse("$base/pet/");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "usuario_id": usuarioId,
        "nome": nome,
        "cor": cor,
      }),
    );

    // DEBUG
    print("POST /pet/ status=${response.statusCode} body=${response.body}");
    return response.statusCode == 200 || response.statusCode == 201;
  }

  // obter pet do user -> GET /pet/{user_id}
  static Future<Map<String, dynamic>?> getPet(String usuarioId) async {
    final url = Uri.parse("$base/pet/$usuarioId");
    final res = await http.get(url);
    if (res.statusCode != 200) return null;
    return jsonDecode(res.body);
  }
}
