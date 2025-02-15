import 'package:flutter/material.dart';
import 'package:food_hub/domain/reserva.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:food_hub/widgets/big_text.dart';
import 'package:food_hub/models/sede.dart';
import 'package:food_hub/utils/dimensions.dart';
import 'package:food_hub/pages/home/main_food_page.dart';
import 'package:provider/provider.dart';
import 'package:food_hub/providers/auth_provider.dart';
import 'package:food_hub/providers/reserva_provider.dart';

class ResumenPage extends StatelessWidget {
  final Sede sede;
  final String requerimientos;
  final DateTime fechaHora;
  final int cantidadPersonas;
  final String zonaPreferida;

  const ResumenPage({
    Key? key,
    required this.sede,
    required this.requerimientos,
    required this.fechaHora,
    required this.cantidadPersonas,
    required this.zonaPreferida,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final usuario = authProvider.currentUser;

    String formattedDate = DateFormat('yyyy-MM-dd').format(fechaHora);
    String formattedTime = DateFormat('HH:mm:ss').format(fechaHora);

    String fechaHoraUnida = DateFormat('yyyy-MM-dd HH:mm:ss').format(fechaHora);

    // Determinar idSede según la dirección
  int idSede;
  if (sede.direccion == 'C. Armando Blondet 265, San Isidro 15047') {
    idSede = 1;
  } else if (sede.direccion == 'Av. Aviación 2633, San Borja 15037') {
    idSede = 2;
  } else {
    idSede = 0; // Valor por defecto si la dirección no coincide
  }
  // Determinar idZona según idSede y zonaPreferida
  int idZona;
  if (idSede == 1) {
    idZona = (zonaPreferida == 'Terraza') ? 1 : (zonaPreferida == 'Salón Principal') ? 2 : (zonaPreferida == 'Barra') ? 3 : 0;
  } else if (idSede == 2) {
    idZona = (zonaPreferida == 'Terraza') ? 4 : (zonaPreferida == 'Salón Principal') ? 5 : (zonaPreferida == 'Barra') ? 6 : 0;
  } else {
  idZona = 0; // Valor por defecto si no coincide
  }

    return Scaffold(
      appBar: AppBar(title: Text("Resumen de la Reserva")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Detalles de tu reserva",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
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
                  Row(children: [
                    Text('Sede: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(sede.nombre, style: TextStyle(fontSize: 18)),
                  ]),
                  Row(children: [
                    Icon(Icons.location_on, size: 16, color: Colors.black54),
                    SizedBox(width: 5),
                    Text(sede.direccion, style: TextStyle(fontSize: 14)),
                  ]),
                  SizedBox(height: 10),
                  Row(children: [
                    Text('Fecha: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(formattedDate, style: TextStyle(fontSize: 18)),
                  ]),
                  SizedBox(height: 10),
                  Row(children: [
                    Text('Hora: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(formattedTime, style: TextStyle(fontSize: 18)),
                  ]),
                  SizedBox(height: 10),
                  Row(children: [
                    Text('Cantidad de personas: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(cantidadPersonas.toString(),
                        style: TextStyle(fontSize: 18)),
                  ]),
                  SizedBox(height: 10),
                  Row(children: [
                    Text('Zona preferida: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(zonaPreferida, style: TextStyle(fontSize: 18)),
                  ]),
                  SizedBox(height: 10),
                  Row(children: [
                    Text('Requerimientos: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(requerimientos.isEmpty ? "Ninguno" : requerimientos,
                        style: TextStyle(fontSize: 18)),
                  ]),
                ],
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: InkWell(
                onTap: () {
                  ReserveProvider().registerReserve(
                    idUsuario: usuario?.id ?? 0,
                    idSede: idSede,
                    idZona: idZona,
                    idEstado: 1,
                    fecha: fechaHoraUnida,
                    cantidadPersonas: cantidadPersonas,
                    requerimientos: requerimientos.isEmpty ? "Ninguno" : requerimientos,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      allowSnapshotting: false,
                      builder: (context) => MainFoodPage(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20 * 2,
                    vertical: Dimensions.height10,
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
