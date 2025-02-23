import 'package:flutter/material.dart';
import 'package:food_hub/pages/user/admin_view_page.dart';
import 'package:food_hub/providers/auth_provider.dart';
import 'package:food_hub/pages/auth/registro_usuario_page.dart';
import 'package:food_hub/pages/home/main_food_page.dart';
import 'package:food_hub/widgets/Campos_Login_Registro.dart';
import 'package:food_hub/widgets/Boton_Login_Registro.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  String message = "";
  final correoTxtController = TextEditingController();
  final claveTxtController = TextEditingController();

  void handleLogin() async {
    setState(() => _isLoading = true);
    final authProvider = context.read<AuthProvider>();
    // se realiza la petición
    MessageResponse response = await authProvider.login(
        correoTxtController.value.text, claveTxtController.value.text);

    if (response.isSuccessful && context.mounted) {
      await Future.delayed(const Duration(milliseconds: 500));

      // Obtener el usuario autenticado
      final currentUser = authProvider.currentUser;

      setState(() {
        _isLoading = false;
        message = response.message;
      });

      // Redirigir según el rol
      if (currentUser?.typeUser == 'ADMIN') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VistaAdminPage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainFoodPage(),
          ),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
        message = response.message;
      });
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset:
          true, // Esto hace que el contenido se desplace cuando el teclado aparece
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
                  Image.asset("assets/imagenes/Logo.png",
                      height: 150, width: 300),
                  const SizedBox(height: 75), // Espacio después del logo

                  // Cuerpo (Campos de texto y botón)
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: AppTextField(
                        hintText: "Correo electrónico",
                        icon: Icons.person,
                        textController: correoTxtController),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: AppTextField(
                      hintText: "Contraseña",
                      icon: Icons.lock,
                      obscureText: true,
                      textController: claveTxtController,
                    ),
                  ),
                  const SizedBox(height: 50),

                  AppClickableText(
                    text: "Ingresar",
                    onPressed: () {
                      handleLogin();
                    },
                  ),

                  const SizedBox(height: 20),

                  // Texto clickeable debajo del botón "Ingresar"
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          allowSnapshotting: false,
                          builder: (context) => RegistroPage(),
                        ),
                      );
                    },
                    child: Text(
                      "¿No tienes una cuenta? Regístrate",
                      style: TextStyle(
                        color: AppColors
                            .mainColor, // Usando el color principal del botón
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                              color: AppColors.mainColor))
                      : Text(message)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}