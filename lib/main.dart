import 'package:flutter/material.dart';
import 'package:food_hub/pages/home/main_food_page.dart';
import 'package:food_hub/pages/auth/login_page.dart';
import 'package:food_hub/pages/auth/registro_usuario_page.dart';
import 'package:food_hub/pages/reserva/detalle.dart';
import 'package:food_hub/pages/reserva/sedes.dart';
import 'package:food_hub/pages/user/admin_profile_page.dart';
import 'package:food_hub/pages/user/admin_view_page.dart';
import 'package:food_hub/pages/user/user_profile_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/login', // Ruta inicial
      routes: {
        '/': (context) => MainFoodPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegistroPage(),
        '/userProfile': (context) => PerfilUsuarioPage(),
        '/adminProfile': (context) => PerfilAdminPage(),
        '/adminView': (context) => VistaAdminPage(),
        // '/second': (context) => PopularFoodDetail(),
        // '/third': (context) => ThirdScreen(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: RegistroPage(),// CAMBIAR
    );
  }
}
