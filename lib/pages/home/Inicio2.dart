import 'package:flutter/material.dart';

class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/imagenes/Logo.png',
          width: 300, // Ajusta el tamaño según prefieras
        ),
      ),
    );
  }
}
