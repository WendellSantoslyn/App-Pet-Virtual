import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Dark_Icon-192.png'),
              const SizedBox(
                height: 60,
                child: Text('VirtuaPet',
                  style: TextStyle(
                    fontSize: 24,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  child: const Text("Login"),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  child: const Text("Registrar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
