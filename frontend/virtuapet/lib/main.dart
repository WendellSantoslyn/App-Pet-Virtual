import 'package:flutter/material.dart';
import 'services/api.dart';
import 'ui/test_viewer.dart';
import 'ui/user_registrar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:RegisterPage()
      /*home: Scaffold(
        appBar: AppBar(title: const Text("App 3D")),
        body: Center(
          child: FutureBuilder(
            future: Api.checkBackend(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              return Text(snapshot.data.toString());
            },
          ),
        ),
      ),*/
    );
  }
}
