import 'package:flutter/material.dart';
import '../services/user_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginCtrl = TextEditingController();
  final senhaCtrl = TextEditingController();

  bool loading = false;
  final UserService _userService = UserService();

Future<void> login() async {
  setState(() => loading = true);

  try {
    final user = await _userService.loginUser(
      loginCtrl.text.trim(),
      senhaCtrl.text.trim(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Bem-vindo, ${user.login}!")),
    );

    // Se não tiver pet → vai para criar pet
    if (!user.hasPet) {
      Navigator.pushReplacementNamed(context, '/petsetup', arguments: user.id);
      return;
    }

    // Se já tiver pet → vai para home
    Navigator.pushReplacementNamed(context, '/home', arguments: user.id);

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
      appBar: AppBar(title: const Text("Login")),
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
                onPressed: loading ? null : login,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text("Entrar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
