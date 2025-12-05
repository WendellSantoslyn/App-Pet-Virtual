import 'package:flutter/material.dart';
import 'services/api.dart';
import '/ui/dashboard.dart';
import '/ui/home.dart';
import 'ui/user_registrar.dart';
import 'ui/user_login.dart';
import 'ui/petsetup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth Flow',
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/login': (context) => const Login(),
        '/register': (context) => const Registrar(),
        '/petsetup': (context) => const PetSetup(),
        '/dashboard': (context) => const PetDashboard(
              petName: 'Carregando...',
              petColor: 'azul',
            ),
      },
    );
  }
}