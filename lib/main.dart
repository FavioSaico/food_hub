import 'package:flutter/material.dart';
import 'package:food_hub/pages/home/plantilla.dart';
import 'package:food_hub/pages/food/popular_food_detail.dart';
import 'package:food_hub/pages/food/recommended_food_detail.dart';
import 'package:food_hub/pages/home/main_food_page.dart';
import 'package:food_hub/pages/home/login_page.dart';
import 'package:food_hub/pages/home/registro_usuario_page.dart';
import 'package:food_hub/pages/food/RegisterCard.dart';
import 'package:food_hub/pages/home/Inicio1.dart';
import 'package:food_hub/pages/home/Inicio2.dart';
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
      initialRoute: '/iniciolog2', // Ruta inicial
      routes: {
        '/': (context) => MainFoodPage(),
        '/second': (context) => PopularFoodDetail(),
        // '/third': (context) => ThirdScreen(),
        '/register-card': (context) => const RegisterCard(),
        '/iniciolog':(context) => const SplashScreen(),
        '/iniciolog2':(context) => const SplashScreen2(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}