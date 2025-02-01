import 'package:flutter/material.dart';
import 'package:food_hub/pages/home/body_food_page.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/utils/dimensions.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/widgets/big_text.dart';
import 'package:food_hub/widgets/small_text.dart';



class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  _MainFoodPageState createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height60, bottom: Dimensions.height15),
              padding: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(
                          text: "Food Hub",
                          color: AppColors.mainColor,
                          size: 30),
                      SmallText(
                          text: "Descubre el sabor del mar",
                          color: Colors.black54),
                    ],
                  ),
                  Container(
                    width: Dimensions.height45,
                    height: Dimensions.height45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColors.mainColor,
                    ),
                    child: Icon(Icons.search,
                        color: Colors.white, size: Dimensions.iconSize24),
                  ),
                ],
              ),
            ),
          ),
          // Lista de Platos
          Expanded(
            child: SingleChildScrollView(
              child: BodyFoodPage(),
            )
          ),
        ],
      ),
      // Boton de ChatBot
      floatingActionButton: FloatingActionButton(
        enableFeedback: true, // para que no produzca una pequeña vibración
        elevation: 5, // controlamos las sombras
        backgroundColor: AppColors.mainColor,
        shape: StadiumBorder(),
        onPressed: ( ) {},
        child: Icon(Icons.mode_comment, color: Colors.white, size: 30), // pasamos el icono
      ),
      bottomNavigationBar: AppMenu(),
    );
  }
}
