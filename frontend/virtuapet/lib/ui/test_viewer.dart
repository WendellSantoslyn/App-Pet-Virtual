import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class TestViewer extends StatelessWidget {
  const TestViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Teste 3D")),
      body: const ModelViewer(
        src: '',
        autoPlay: true,
        cameraControls: true,
        ar: false,
      ),
    );
  }
}
