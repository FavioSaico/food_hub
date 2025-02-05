import 'package:flutter/material.dart';
import 'package:food_hub/pages/auth/login_page.dart';
import 'package:food_hub/providers/auth_provider.dart';
import 'package:food_hub/pages/home/main_food_page.dart';
import 'package:food_hub/widgets/Campos_Login_Registro.dart';
import 'package:food_hub/widgets/Boton_Login_Registro.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:provider/provider.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  bool _isLoading = false;
  String message = "";
  final nombreTxtController = TextEditingController();
  final correoTxtController = TextEditingController();
  final claveTxtController = TextEditingController();
  final direccionTxtController = TextEditingController();

  void handleRegister() async {
    setState(() => _isLoading = true);
    final authProvider = context.read<AuthProvider>();
    MessageResponse response =  await authProvider.register(
      nombreTxtController.value.text,
      correoTxtController.value.text,
      claveTxtController.value.text,
      direccionTxtController.value.text,
    );

    if(response.isSuccessful && context.mounted){
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        _isLoading = false;
        message = response.message;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          allowSnapshotting: false,
          builder: (context) => MainFoodPage(),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
        message = response.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          // Ocultar el teclado cuando se hace clic fuera de un campo de texto
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100),

                  // Cabecera (Logo)
                  Image.asset("assets/imagenes/Logo.png", height: 150, width: 300),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: AppTextField(hintText: "Ingrese su Nombre/Apellido", icon: Icons.person, textController: nombreTxtController,),
                  ),
                  const SizedBox(height: 15),
                  
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: AppTextField(hintText: "Dirección de Entrega", icon: Icons.location_on, textController: direccionTxtController,),
                  ),
                  const SizedBox(height: 5),

                  // Cuerpo (Campos de texto y botón)
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: AppTextField(hintText: "Ingrese un correo electrónico", icon: Icons.email, textController: correoTxtController),
                  ),
                  const SizedBox(height: 15),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: AppTextField(hintText: "Ingrese una contraseña", icon: Icons.lock,obscureText: true, textController: claveTxtController,),
                  ),
                  const SizedBox(height: 15),

                  GestureDetector(
                    onTap: () {
                      // Aquí puedes definir lo que quieres que suceda cuando el texto sea presionado
                      print("Usar ubicación actual");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, color: AppColors.mainColor, size: 20),
                        SizedBox(width: 5),
                        Text(
                          "Usar mi ubicación actual",
                          style: TextStyle(
                            color: AppColors.mainColor, // Usando el color principal del botón
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),

                  AppClickableText(
                    text: "Registrarme",
                    onPressed: () {
                      handleRegister();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     allowSnapshotting: false,
                      //     builder: (context) => MainFoodPage(),
                      //   ),
                      // );
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
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      "¡Ya tengo una cuenta!",
                      style: TextStyle(
                        color: AppColors.mainColor, // Usando el color principal del botón
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  _isLoading ? Center(child: CircularProgressIndicator(color: AppColors.mainColor)) : Text(message)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}