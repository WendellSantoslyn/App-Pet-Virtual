import 'package:flutter/material.dart';
import 'home.dart';
import 'petsetup.dart';
import '../services/api.dart';  // Onde está sua comunicação com o Python

class PostLoginWrapper extends StatelessWidget {
  const PostLoginWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = Api.userId; // pegue do auth que você usa

    return FutureBuilder(
      future: Api.getPet(uid), // chama backend Python
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final result = snapshot.data;

        if (result == null) {
          // Backend retornou 404 → pet não existe
          return const PetSetup();
        }

        // Pet já existe → Vai para Home
        return const Home();
      },
    );
  }
}
