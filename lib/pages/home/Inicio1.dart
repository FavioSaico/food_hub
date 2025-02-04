import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),

            // Logo de FOODHUB
            Image.asset(
              'assets/imagenes/Logo.png',
              width: 200, // Ajusta según el tamaño que prefieras
            ),

            const Spacer(flex: 2),

            // Texto de colaboración
            const Text(
              "En colaboración con:",
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 10),

            // Logo de EL ESCONDITE
            Image.asset(
              'assets/imagenes/ElEscondite.png',
              width: 120, // Ajusta según el tamaño que prefieras
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}