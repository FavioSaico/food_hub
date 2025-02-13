import 'package:flutter/material.dart';
import 'package:food_hub/pages/reserva/resumen.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/pages/home/body_food_page.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/utils/dimensions.dart';
import 'package:food_hub/widgets/app_icon.dart';
import 'package:food_hub/widgets/big_text.dart';
import 'package:food_hub/widgets/small_text.dart';
import 'package:food_hub/pages/reserva/detalle.dart';
import 'package:food_hub/models/sede.dart';

class SedesPage extends StatefulWidget {
  const SedesPage({super.key});

  @override
  SedesPageState createState() => SedesPageState();
}

class SedesPageState extends State<SedesPage> {
  int selectedIndex = -1;
  final Color defaultColor = Colors.white;
  final Color selectedColor = AppColors.mainColor;

  // Lista de sedes usando la clase Sede en lugar de Map
  final List<Sede> sedes = [
    Sede(
      nombre: "El Escondite",
      descripcion: "Restaurant & Cevichería",
      direccion: "C. Armando Blondet 265, San Isidro 15047",
      imagen: "assets/imagenes/sede2.png",
    ),
    Sede(
      nombre: "El Escondite",
      descripcion: "Restaurant & Cevichería",
      direccion: "Av. Aviación 2633, San Borja 15037",
      imagen: "assets/imagenes/sede1.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Header de la página
          Container(
            margin: EdgeInsets.only(
                top: Dimensions.height60, bottom: Dimensions.height15),
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset("assets/imagenes/Logo.png",
                        height: 70, width: 140),
                    const SizedBox(height: 15), // Espacio después del logo
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        "Elije una de nuestras sedes",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ],
            ),
          ),
          // ListView de las sedes
          Expanded(
            child: ListView.builder(
              itemCount: sedes.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    // Imagen de la sede
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage(sedes[index].imagen),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Contenedor con los detalles superpuestos
                    Positioned(
                      bottom: 15,
                      left: 20,
                      right: 20,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = selectedIndex == index ? -1 : index;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? selectedColor
                                : defaultColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                sedes[index].nombre,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: selectedIndex == index
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                sedes[index].descripcion,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: selectedIndex == index
                                      ? Colors.white
                                      : Colors.black54,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : Colors.black54,
                                    size: 16,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    sedes[index].direccion,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: selectedIndex == index
                                          ? Colors.white
                                          : Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // Botón para pasar a la siguiente página
          InkWell(
            onTap: () {
              if (selectedIndex != -1) {
                Sede sedeSeleccionada = sedes[selectedIndex];

                // Navegar a la página de detalles, pasando el objeto Sede
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetallePage(sedeSeleccionada: sedeSeleccionada),
                  ),
                );
              }
            },
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20 * 2,
                right: Dimensions.width20 * 2,
                top: Dimensions.height10,
                bottom: Dimensions.height10,
              ),
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(Dimensions.radius15),
              ),
              child: BigText(
                text: "Siguiente",
                color: Colors.white,
                size: Dimensions.font16,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppMenu(),
        ],
      ),
    );
  }
}
