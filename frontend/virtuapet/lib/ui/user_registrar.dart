import 'package:flutter/material.dart';
import '../services/user_service.dart';

class Registrar extends StatefulWidget {
  const Registrar({super.key});

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  final loginCtrl = TextEditingController();
  final senhaCtrl = TextEditingController();

  bool loading = false;
  final UserService _userService = UserService();

  Future<void> registrar() async {
    setState(() => loading = true);

    try {
      final user = await _userService.createUser(
        loginCtrl.text.trim(),
        senhaCtrl.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Usuário criado! ID: ${user.id}")),
      );

      Navigator.pop(context); // volta pra tela anterior
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e")),
      );
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registrar Usuário")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Login"),
            TextField(controller: loginCtrl),

            const SizedBox(height: 16),

            const Text("Senha"),
            TextField(
              controller: senhaCtrl,
              obscureText: true,
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : registrar,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text("Criar Usuário"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
