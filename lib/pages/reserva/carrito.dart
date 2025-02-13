
import 'package:flutter/material.dart';
import 'package:food_hub/widgets/app_menu.dart';

class CarritoPage extends StatelessWidget {
  const CarritoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text('Página de Carrito', style: TextStyle(fontSize: 24))),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppMenu(),
        ],
      ),
    );
    // return Center(child: Text('Página de Carrito', style: TextStyle(fontSize: 24)));
  }
}
