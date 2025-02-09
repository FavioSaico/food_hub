import 'package:flutter/material.dart';
import 'package:food_hub/pages/auth/login_page.dart';
import 'package:food_hub/pages/reserva/detalle.dart';
import 'package:food_hub/pages/reserva/sedes.dart';
import 'package:food_hub/pages/user/user_profile_change_password_page.dart';
import 'package:food_hub/providers/auth_provider.dart';
import 'package:food_hub/providers/food_provider.dart';
import 'package:food_hub/pages/auth/registro_usuario_page.dart';

import 'package:food_hub/pages/home/main_food_page.dart';
import 'package:food_hub/pages/food/RegisterCard.dart';
import 'package:food_hub/pages/home/Inicio1.dart';
import 'package:food_hub/pages/home/Inicio2.dart';
import 'package:food_hub/pages/reserva/detalle.dart';
import 'package:food_hub/pages/reserva/sedes.dart';

import 'package:food_hub/pages/user/admin_profile_page.dart';
import 'package:food_hub/pages/user/admin_view_page.dart';
import 'package:food_hub/pages/user/user_profile_page.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FoodProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
<<<<<<< HEAD
        initialRoute: '/sedes_reserva', // Ruta inicial
=======
        initialRoute: '/iniciolog2', // Ruta inicial
>>>>>>> 57a0628d456b1a29d39e5680f549c1ddaf882fcb
        routes: {
          '/': (context) => MainFoodPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegistroPage(),
          '/userProfile': (context) => PerfilUsuarioPage(),
          '/adminProfile': (context) => PerfilAdminPage(),
          '/adminView': (context) => VistaAdminPage(),
          '/register-card': (context) => const RegisterCard(),
<<<<<<< HEAD
          '/iniciolog': (context) => const SplashScreen(),
          '/iniciolog2': (context) => const SplashScreen2(),
          '/reserva': (context) => DetallePage(),
          '/sedes_reserva': (context) => SedesPage(),
=======
          '/iniciolog':(context) => const SplashScreen(),
          '/iniciolog2':(context) => const SplashScreen2(),
          '/reserva':(context) => DetallePage(),
          '/sedes_reserva':(context) => SedesPage(),
          '/cambio_contraseña':(context) => CambiarContrasenaPage()
>>>>>>> 57a0628d456b1a29d39e5680f549c1ddaf882fcb
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
