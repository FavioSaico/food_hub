import 'package:flutter/material.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:food_hub/providers/auth_provider.dart';

class CambiarContrasenaPage extends StatefulWidget {
  const CambiarContrasenaPage({super.key});

  @override
  _CambiarContrasenaPageState createState() => _CambiarContrasenaPageState();
}

class _CambiarContrasenaPageState extends State<CambiarContrasenaPage> {
  final TextEditingController _actualController = TextEditingController();
  final TextEditingController _nuevaController = TextEditingController();
  final TextEditingController _confirmarController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final usuario = authProvider.currentUser;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Ocultar teclado al tocar fuera
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Cambiar contraseña', style: TextStyle(color: AppColors.mainColor)),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: AppColors.mainColor),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left, color: Colors.white),
            style: IconButton.styleFrom(backgroundColor: AppColors.mainColor),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildPasswordField('Ingrese su contraseña actual', _actualController),
              const SizedBox(height: 15),
              _buildPasswordField('Ingrese su nueva contraseña', _nuevaController),
              const SizedBox(height: 15),
              _buildPasswordField('Ingrese nuevamente la nueva contraseña', _confirmarController),
              const SizedBox(height: 30),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: () => Get.back(),
                          child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor),
                          onPressed: () => _guardarContrasena(usuario?.id ?? 0),
                          child: const Text('Guardar', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
            ],
          ),
        ),
        bottomNavigationBar: AppMenu(),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: () => setState(() => _obscureText = !_obscureText),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  void _guardarContrasena(int userId) async {
    if (_nuevaController.text != _confirmarController.text) {
      Get.snackbar('Error', 'Las contraseñas no coinciden', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    setState(() => _isLoading = true);

    final response = await AuthProvider().changePassword(
      userId,
      _actualController.text,
      _nuevaController.text,
    );

    setState(() => _isLoading = false);

    if (response.isSuccessful) {
   Get.snackbar('Éxito', 'Contraseña cambiada con éxito', backgroundColor: Colors.green, colorText: Colors.white);
   Navigator.pushNamed(context, '/userProfile');
    } else {
  Get.snackbar('Error', response.message, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
