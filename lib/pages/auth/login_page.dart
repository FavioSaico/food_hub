import 'package:flutter/material.dart';
import 'package:food_hub/widgets/Campos_Login_Registro.dart';
import 'package:food_hub/widgets/Boton_Login_Registro.dart';
import 'package:food_hub/utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // Esto hace que el contenido se desplace cuando el teclado aparece
      body: GestureDetector(
        onTap: () {
          // Ocultar el teclado cuando se hace clic fuera de un campo de texto
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  SizedBox(height: 130), // Espacio antes del logo

                  // Cabecera (Logo)
                  Image.asset("assets/imagenes/Logo.png", height: 150, width: 300),
                  const SizedBox(height: 75), // Espacio después del logo

                  // Cuerpo (Campos de texto y botón)
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: AppTextField(hintText: "Usuario / Correo electrónico", icon: Icons.person),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: AppTextField(hintText: "Contraseña", icon: Icons.lock,obscureText: true),
                  ),
                  const SizedBox(height: 50),

                  AppClickableText(
                    text: "Ingresar"
                  ),

                  const SizedBox(height: 20),  

                  // Texto clickeable debajo del botón "Ingresar"
                  GestureDetector(
                    onTap: () {
                      print("Redirigir a la página de registro");
                    },
                    child: Text(
                      "¿No tienes una cuenta? Regístrate",
                      style: TextStyle(
                        color: AppColors.mainColor, // Usando el color principal del botón
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}