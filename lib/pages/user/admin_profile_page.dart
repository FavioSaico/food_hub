import 'package:flutter/material.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/widgets/app_icon.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/widgets/big_text.dart';
import 'package:food_hub/widgets/bold_normal_text.dart';
import 'package:food_hub/widgets/build_menu_option.dart';
import 'package:provider/provider.dart';
import 'package:food_hub/providers/auth_provider.dart';

class PerfilAdminPage extends StatefulWidget {
  const PerfilAdminPage({super.key});

  @override
  _PerfilAdminPageState createState() => _PerfilAdminPageState();
}

class _PerfilAdminPageState extends State<PerfilAdminPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final usuario = authProvider.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
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
              text: usuario?.name ??
                  'Usuario no identificado', // Mostramos el nombre del usuario o un mensaje predeterminado
              color: AppColors.mainBlackColor,
              size: 24,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoldNormalText(
                      label: 'Correo',
                      value: usuario?.email ?? 'No disponible'),
                  BoldNormalText(
                      label: 'Dirección',
                      value: usuario?.address ?? 'No disponible'),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Opciones del menú

            BuildMenuOption(
              text: 'Cambio de contraseña',
              onTap: () {
                Navigator.pushNamed(context, '/cambio_contraseña');
              },
            ),
            BuildMenuOption(
              text: 'Cerrar sesión',
              onTap: () {
                authProvider.logout();
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
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
