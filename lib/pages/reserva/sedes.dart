import 'package:flutter/material.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/pages/home/body_food_page.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/utils/dimensions.dart';
import 'package:food_hub/widgets/app_icon.dart';
import 'package:food_hub/widgets/big_text.dart';
import 'package:food_hub/widgets/small_text.dart';

class SedesPage extends StatefulWidget {
  const SedesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SedesPageState createState() => _SedesPageState();
}

class _SedesPageState extends State<SedesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // body: // Cuerpo de la aplicación
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
                          size: 30),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          "Elije una de nuestras sedes",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainColor),
                        ),
                      ),
                      const SizedBox(height: 25),
                    ],
                  )
                ],
              ),
            ),
          ),
          //List vie de sedes
          Expanded(
            child: ListView.builder(
              itemCount: 2, // Número de elementos en la lista
              itemBuilder: (context, index) {
                // Lista de datos de ejemplo (puedes cambiarlo por datos dinámicos)
                final List<Map<String, String>> sedes = [
                  {
                    "nombre": "El Escondite",
                    "descripcion": "Restaurant & Cevichería",
                    "direccion": "C. Armando Blondet 295, San Isidro 15047",
                    "imagen": "assets/imagenes/sede1.png",
                    "color": "0xFF6EC6A7" // Color verde agua
                  },
                  {
                    "nombre": "El Escondite",
                    "descripcion": "Restaurant & Cevichería",
                    "direccion": "Av. Aviación 2633, San Borja 15027",
                    "imagen": "assets/imagenes/sede1.png",
                    "color": "0xFFFFFFFF" // Color blanco
                  },
                ];

                return Stack(
                  children: [
                    // Imagen de la sede
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      height: 200, // Ajusta el tamaño de la imagen
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage(sedes[index]["imagen"]!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Contenedor con los detalles superpuestos
                    Positioned(
                      bottom: 15,
                      left: 20,
                      right: 20,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(int.parse(
                              sedes[index]["color"]!)), // Color del fondo
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5,
                              spreadRadius: 2,
                              offset: Offset(0, 3),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              sedes[index]["nombre"]!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              sedes[index]["descripcion"]!,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.location_on,
                                    color: Colors.black54, size: 16),
                                SizedBox(width: 5),
                                Text(
                                  sedes[index]["direccion"]!,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          //Boton Siguiente

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
