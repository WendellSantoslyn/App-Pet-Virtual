import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../services/api.dart';

class PetSetup extends StatefulWidget {
  const PetSetup({super.key});

  @override
  State<PetSetup> createState() => _PetSetupState();
}

class _PetSetupState extends State<PetSetup> {
  final nameCtrl = TextEditingController();
  String? selectedColor;
  final colors = ["Azul", "Amarelo", "Vermelho"];
  bool saving = false;

  Future<void> savePet() async {
    if (nameCtrl.text.isEmpty || selectedColor == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Preencha tudo")));
      return;
    }

    setState(() => saving = true);

    final success = await Api.createPet(Api.userId, nameCtrl.text, selectedColor!);

    setState(() => saving = false);

    if (!success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Erro ao salvar")));
      return;
    }

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configurar seu Pet")),
      body: Row(
        children: [
          Expanded(
            child: ModelViewer(
              src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
              autoRotate: true,
              cameraControls: true,
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Nome do Pet:", style: TextStyle(fontSize: 18)),
                  TextField(controller: nameCtrl),

                  const SizedBox(height: 20),
                  const Text("Escolha uma cor:", style: TextStyle(fontSize: 18)),

                  DropdownButton<String>(
                    hint: const Text("Selecionar cor"),
                    value: selectedColor,
                    items: colors.map((c) {
                      return DropdownMenuItem(value: c, child: Text(c));
                    }).toList(),
                    onChanged: (v) => setState(() => selectedColor = v),
                  ),

                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: saving ? null : savePet,
                    child: saving
                        ? const CircularProgressIndicator()
                        : const Text("Salvar pet"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
