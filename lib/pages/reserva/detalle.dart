import 'package:flutter/material.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/pages/home/body_food_page.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/utils/dimensions.dart';
import 'package:food_hub/widgets/app_icon.dart';
import 'package:food_hub/widgets/big_text.dart';
import 'package:food_hub/widgets/btnatras.dart';
import 'package:food_hub/widgets/cantidadpersonas.dart';
import 'package:food_hub/widgets/fechayhora.dart';
import 'package:food_hub/widgets/small_text.dart';
import 'package:food_hub/widgets/zona.dart';
import 'package:food_hub/models/sede.dart';
import 'package:food_hub/pages/reserva/resumen.dart';

class DetallePage extends StatefulWidget {
  final Sede sedeSeleccionada;

  const DetallePage({super.key, required this.sedeSeleccionada});

  @override
  DetallePageState createState() => DetallePageState();
}

class DetallePageState extends State<DetallePage> {
  final TextEditingController requerimientosController =
      TextEditingController();

  DateTime? fechaSeleccionada;
  String horaSeleccionada = "Seleccionar hora";
  int cantidadPersonas = 1;
  String zonaPreferida = "Terraza";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: BackButtonCustom(),
            ),
            const SizedBox(height: 10),
            //logo
            Center(
              child: Image.asset("assets/imagenes/Logo.png",
                  height: 70, width: 140),
            ),
            const SizedBox(height: 15),
            // Mostrar sede seleccionada
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Sede: ${widget.sedeSeleccionada.direccion}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

// Widgets para seleccionar datos
            FechaHoraSelector(
              onFechaHoraSeleccionada: (fecha, hora) {
                setState(() {
                  fechaSeleccionada = fecha;
                  horaSeleccionada = hora;
                });
              },
            ),
            CantidadPersonasSelector(
              onCantidadSeleccionada: (cantidad) {
                setState(() {
                  cantidadPersonas = cantidad;
                });
              },
            ),
            ZonaPreferidaWidget(
              onZonaSeleccionada: (zona) {
                setState(() {
                  zonaPreferida = zona;
                });
              },
            ),

// Campo de requerimientos
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.8, // Ocupa el 80% del ancho de la pantalla
                child: TextField(
                  controller: requerimientosController,
                  decoration: InputDecoration(
                    hintText: "Ingrese detalles adicionales...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

// Botón para ir al resumen
            Center(
              child: InkWell(
                onTap: () {
                  // Navegar a la página de resumen pasando los datos
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResumenPage(
                        sede: widget.sedeSeleccionada,
                        fecha: fechaSeleccionada?.toIso8601String() ?? "",
                        hora: horaSeleccionada,
                        cantidadPersonas: cantidadPersonas,
                        zonaPreferida: zonaPreferida,
                        requerimientos: requerimientosController.text,
                      ),
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
                    text: "Guardar",
                    color: Colors.white,
                    size: Dimensions.font16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppMenu(),
    );
  }
}
