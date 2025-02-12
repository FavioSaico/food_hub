import 'package:flutter/material.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:intl/intl.dart';

import 'package:food_hub/widgets/big_text.dart';
import 'package:food_hub/pages/reserva/sedes.dart';
import 'package:food_hub/pages/reserva/detalle.dart';
import 'package:food_hub/models/sede.dart';
import 'package:food_hub/utils/dimensions.dart';
import 'package:food_hub/pages/home/main_food_page.dart';

class ResumenPage extends StatelessWidget {
  final Sede sede;
  final String requerimientos;
  final String fecha;
  final String hora;
  final int cantidadPersonas;
  final String zonaPreferida;

  const ResumenPage({
    Key? key,
    required this.sede,
    required this.requerimientos,
    required this.fecha,
    required this.hora,
    required this.cantidadPersonas,
    required this.zonaPreferida,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convertir la fecha en un formato legible
    String formattedDate = fecha.isNotEmpty
        ? DateFormat('MMMM d, yyyy').format(DateTime.parse(fecha))
        : "No seleccionada";

    return Scaffold(
      appBar: AppBar(
        title: Text("Resumen de la Reserva"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de la página
            Text(
              "Detalles de tu reserva",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Cuadro de resumen de la reserva
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sede seleccionada
                  Row(
                    children: [
                      Text(
                        'Sede: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(sede.nombre, style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 5),
                      Text(sede.direccion, style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Fecha seleccionada
                  Row(
                    children: [
                      Text(
                        'Fecha: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(formattedDate, style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Hora seleccionada
                  Row(
                    children: [
                      Text(
                        'Hora: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(hora, style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Cantidad de personas
                  Row(
                    children: [
                      Text(
                        'Cantidad de personas: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(cantidadPersonas.toString(),
                          style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Zona preferida
                  Row(
                    children: [
                      Text(
                        'Zona preferida: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(zonaPreferida, style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Requerimientos adicionales
                  Row(
                    children: [
                      Text(
                        'Requerimientos: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        requerimientos.isEmpty ? "Ninguno" : requerimientos,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Botón para confirmar la reserva (esto es opcional)
            Center(
              child: InkWell(
                onTap: () {
                  // Aquí iría la lógica para guardar o procesar la reserva
                  //  enviar a la base de datos

                  // Luego de procesar la reserva, redirigir a MainFoodPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      allowSnapshotting: false,
                      builder: (context) => MainFoodPage(),
                    ),
                  );
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
                    text: "Confirmar",
                    color: Colors.white,
                    size: Dimensions.font16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: AppMenu(),
    );
  }
}
