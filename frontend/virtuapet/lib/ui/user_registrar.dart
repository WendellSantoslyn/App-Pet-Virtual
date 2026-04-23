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

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Usuário criado! ID: ${user.id}")));

      Navigator.pop(context); // volta pra tela anterior
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro: $e")));
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registrar Usuário")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //const Text("Login"),
              SizedBox(
                width: 400,
                child: TextField(
                  controller: loginCtrl,
                  decoration: InputDecoration(labelText: 'Nome de Usuário'),
                ),
              ),

              const SizedBox(height: 16),

              //const Text("Senha"),
              SizedBox(
                width: 400,
                child: TextField(
                  controller: senhaCtrl,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Senha'),
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: loading ? null : registrar,
                  child: loading
                      ? const CircularProgressIndicator()
                      : const Text("Criar Usuário"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
