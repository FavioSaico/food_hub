import 'package:flutter/material.dart';
import 'package:food_hub/pages/user/admin_compras.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/widgets/build_menu_option.dart';
import 'package:food_hub/widgets/small_text.dart';
import 'package:food_hub/pages/user/admin_reservas.dart';

class VistaAdminPage extends StatefulWidget {
  const VistaAdminPage({super.key});

  @override
  _VistaAdminPageState createState() => _VistaAdminPageState();
}

class _VistaAdminPageState extends State<VistaAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 20),
          Image.asset("assets/imagenes/Logo.png", height: 70, width: 140),
          Transform.translate(
            offset: const Offset(0, -8), // Mueve el texto hacia arriba
            child: SmallText(text: 'Administrador', color: Colors.grey),
          ),
          const SizedBox(height: 20),
          BuildMenuOption(
            text: "Lista de reservas",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AdminReservasPage()),
              );
            },
          ),
          BuildMenuOption(
            text: "Lista de compras",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminComprasPage()),
              );
            },
          ),
          const Expanded(
            child: Center(
              child: Image(
                image: AssetImage("assets/imagenes/admin_view.png"),
                fit: BoxFit.contain,
              ),
            ),
          ),
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
