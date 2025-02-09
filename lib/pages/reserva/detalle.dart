import 'package:flutter/material.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/pages/home/body_food_page.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/utils/dimensions.dart';
import 'package:food_hub/widgets/app_icon.dart';
import 'package:food_hub/widgets/big_text.dart';
import 'package:food_hub/widgets/cantidadpersonas.dart';
import 'package:food_hub/widgets/fechayhora.dart';
import 'package:food_hub/widgets/small_text.dart';
import 'package:food_hub/widgets/zona.dart';

class DetallePage extends StatefulWidget {
  @override
  _DetallePageState createState() => _DetallePageState();
}

class _DetallePageState extends State<DetallePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //cuerpo de la aplicacion
      body: Column(
        mainAxisSize: MainAxisSize.max,
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
                          size: 25),
                    ],
                  )
                ],
              ),
            ),
          ),
          FechaHoraSelector(),
          CantidadPersonasSelector(),
          ZonaPreferidaWidget(),
          //requerimientos especiales
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Requerimientos especiales:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width *
                          0.8, // 80% del ancho de la pantalla
                    ),
                    child: TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: "Ingrese detalles adicionales...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.only(
              left: Dimensions.width20 * 2,
              right: Dimensions.width20 * 2,
              top: Dimensions.height10,
              bottom: Dimensions.height10,
            ),
            decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius15),
                  topRight: Radius.circular(Dimensions.radius15),
                  bottomLeft: Radius.circular(Dimensions.radius15),
                  bottomRight: Radius.circular(Dimensions.radius15),
                )),
            child: BigText(
                text: "Siguiente",
                color: Colors.white,
                size: Dimensions.font16),
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
