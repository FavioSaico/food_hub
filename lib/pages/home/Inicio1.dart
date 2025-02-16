import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_hub/domain/user.dart';
import 'package:food_hub/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    checkUserSession();
    // Future.delayed(Duration(seconds: 2), () {
    //   Navigator.pushReplacementNamed(context, '/login');
    // });
  }

  void checkUserSession() async {
    final authProvider = context.read<AuthProvider>();
    await authProvider.getUserSesion();
    
    if (authProvider.usuario != null) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/');
      });
    } else {
      // No hay usuario guardado, ir a Login
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }
  }

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