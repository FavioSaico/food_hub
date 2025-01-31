import 'package:flutter/material.dart';
import 'package:food_hub/widgets/app_menu.dart';

class PlantillaPage extends StatefulWidget {
  const PlantillaPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PlantillaPageState createState() => _PlantillaPageState();
}

class _PlantillaPageState extends State<PlantillaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // body: // Cuerpo de la aplicación

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