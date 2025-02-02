import 'package:flutter/material.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/widgets/app_icon.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/widgets/big_text.dart';
import 'package:food_hub/widgets/bold_normal_text.dart';
import 'package:food_hub/widgets/build_menu_option.dart';

class PerfilUsuarioPage extends StatefulWidget {
  const PerfilUsuarioPage({super.key});

  @override
  _PerfilUsuarioPageState createState() => _PerfilUsuarioPageState();
}

class _PerfilUsuarioPageState extends State<PerfilUsuarioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 60),
          BigText(
            text: 'Perfil',
            color: AppColors.mainColor,
            size: 24,
          ),
          const SizedBox(height: 10),
          AppIcon(
            icon: Icons.person_outline,
            iconColor: Colors.white,
            backgroundColor: Colors.grey,
            size: 150,
            iconSize: 120,
          ),
          const SizedBox(height: 16),
          BigText(
            text: 'Juan Pérez',
            color: AppColors.mainBlackColor,
            size: 24,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoldNormalText(label: 'Correo electrónico', value: 'juanperez@gmail.com'),
                BoldNormalText(label: 'Dirección', value: 'Avenida Elmer Faucett, 265'),
              ],
            ),
          ),
          const SizedBox(height: 30),
          // Opciones del menú
          BuildMenuOption(text: 'Historial de compras'),
          BuildMenuOption(text: 'Historial de reservas'),
          BuildMenuOption(text: 'Cambiar contraseña'),
          BuildMenuOption(text: 'Cerrar sesión'),
        ],
      ),
      // Menú
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppMenu() // widget de menú
        ],
      ),
    );
  }
}