import 'package:flutter/material.dart';
import 'package:food_hub/pages/home/plantilla.dart';
import 'package:food_hub/pages/food/popular_food_detail.dart';
import 'package:food_hub/pages/food/recommended_food_detail.dart';
import 'package:food_hub/pages/home/main_food_page.dart';
import 'package:food_hub/pages/home/login_page.dart';
import 'package:food_hub/pages/home/registro_usuario_page.dart';
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
      initialRoute: '/', // Ruta inicial
      routes: {
        '/': (context) => MainFoodPage(),
        '/second': (context) => PopularFoodDetail(),
        // '/third': (context) => ThirdScreen(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RegistroPage(),// CAMBIAR
    );
  }
}