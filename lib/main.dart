import 'package:flutter/material.dart';
import 'package:food_hub/pages/home/main_food_page.dart';
// import 'package:food_hub/pages/home/login_page.dart';
// import 'package:food_hub/pages/home/registro_usuario_page.dart';
import 'package:food_hub/pages/food/RegisterCard.dart';
import 'package:food_hub/pages/home/Inicio1.dart';
import 'package:food_hub/pages/home/Inicio2.dart';
import 'package:food_hub/pages/user/admin_profile_page.dart';
import 'package:food_hub/pages/user/admin_view_page.dart';
import 'package:food_hub/pages/user/user_profile_page.dart';
import 'package:food_hub/pages/pago/compra.dart';
import 'package:food_hub/pages/pago/Pagorealizado.dart';
import 'package:food_hub/pages/pago/compratienda.dart';
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
      initialRoute: '/pagorealizado', // Ruta inicial

      routes: {
        '/': (context) => MainFoodPage(),
        // '/login': (context) => LoginPage(),
        // '/register': (context) => RegistroPage(),
        '/userProfile': (context) => PerfilUsuarioPage(),
        '/adminProfile': (context) => PerfilAdminPage(),
        '/adminView': (context) => VistaAdminPage(),
        // '/second': (context) => PopularFoodDetail(),
        // '/third': (context) => ThirdScreen(),
        '/register-card': (context) => const RegisterCard(),
        '/iniciolog':(context) => const SplashScreen(),
        '/pagoefectuado':(context)=> const PaymentScreen(),
        '/pagoefectuadotienda':(context)=>const PaymentScreen2(),
        '/pagorealizado':(context)=>const PagoRealizadoPage(numeroCompra: "0003", monto: 168.00),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
