import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class PetDashboard extends StatefulWidget {
  final String petName;
  final String petColor; // ex: "azul", "amarelo", "vermelho"

  const PetDashboard({
    super.key,
    required this.petName,
    required this.petColor,
  });

  @override
  State<PetDashboard> createState() => _PetDashboardState();
}

class _PetDashboardState extends State<PetDashboard> {
  String? currentAnimation;

  // Se quiser forçar reload do ModelViewer (caso mudar animationName não funcione em algum modelo)
  // você pode alternar esta key para reconstruir o widget.
  Key viewerKey = const ValueKey('model-viewer-0');

  void _playAnimation(String animationName) {
    setState(() {
      currentAnimation = animationName;
      // troca a key rapidamente para forçar reload (opcional)
      viewerKey = ValueKey('model-viewer-${DateTime.now().millisecondsSinceEpoch}');
    });
  }

  String _modelPathForColor(String color) {
    // padronize nomes dos arquivos em minúsculas: pet_azul.glb, pet_amarelo.glb, pet_vermelho.glb
    final c = color.toLowerCase();
    return 'assets/models/cachorro_$c.glb';
  }

  @override
  Widget build(BuildContext context) {
    final modelPath = _modelPathForColor(widget.petColor);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.petName,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // área do model viewer
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ModelViewer(
                key: viewerKey,
                src: modelPath,
                alt: 'Pet virtual',
                ar: false,
                autoRotate: true,
                autoPlay: true,
                cameraControls: true,
                // Se quiser que um nome de animação específico toque:
                animationName: currentAnimation, // pode ser null -> usa a primeira animação do modelo
                // Outras props úteis:
                exposure: 1.0,
                shadowIntensity: 0.5,
              ),
            ),
          ),

          // botões para acionar animações
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _playAnimation('Jump'), // nome da action no .glb
                  child: const Text('Pular'),
                ),
                ElevatedButton(
                  onPressed: () => _playAnimation('Wave'),
                  child: const Text('Acenar'),
                ),
                ElevatedButton(
                  onPressed: () => _playAnimation('Dance'),
                  child: const Text('Dançar'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
