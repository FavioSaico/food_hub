import 'package:flutter/material.dart';
import 'package:food_hub/domain/reserva.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/utils/dimensions.dart';

class AdminReservasPage extends StatefulWidget {
  const AdminReservasPage({super.key});
  @override
  _AdminReservasPageState createState() => _AdminReservasPageState();
}

class BackButtonCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.0), // Ajuste para pegarlo más al borde
      child: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _AdminReservasPageState extends State<AdminReservasPage> {
  @override
  void initState() {
    super.initState();
  }

  List<Reserva> listareservas = [
    Reserva(
      cantidad_personas: 1,
      id_zona: 1,
      id_estado: 1,
      id_reserva: 1,
      id_sede: 1,
      id_usuario: 1,
      fecha: DateTime.now(),
      detalle: "Ninguno",
    ),
    Reserva(
      cantidad_personas: 2,
      id_zona: 1,
      id_estado: 2,
      id_reserva: 2,
      id_sede: 1,
      id_usuario: 2,
      fecha: DateTime.now().add(Duration(days: 1)),
      detalle: "Ninguno",
    ),
    Reserva(
      cantidad_personas: 3,
      id_zona: 1,
      id_estado: 3,
      id_reserva: 3,
      id_sede: 1,
      id_usuario: 3,
      fecha: DateTime.now().add(Duration(days: 2)),
      detalle: "Ninguno",
    ),
  ];

  String getEstado(int idEstado) {
    switch (idEstado) {
      case 1:
        return 'En proceso';
      case 2:
        return 'Enviado';
      case 3:
        return 'Finalizado';
      default:
        return 'Desconocido';
    }
  }

  IconData getEstadoIcon(int idEstado) {
    switch (idEstado) {
      case 1:
        return Icons.access_time;
      case 2:
        return Icons.local_shipping;
      case 3:
        return Icons.check_circle;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 🔹 Header modificado: Flecha arriba, texto centrado abajo
          Container(
            margin: EdgeInsets.only(
                top: Dimensions.height60, bottom: Dimensions.height15),
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
            child: Column(
              // 🔹 Usamos Column en lugar de Row
              children: [
                Align(
                  alignment:
                      Alignment.centerLeft, // 🔹 Flecha alineada a la izquierda
                  child: BackButtonCustom(),
                ),
                SizedBox(height: 10), // 🔹 Espaciado entre flecha y texto
                Text(
                  "Historial de reservas",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainColor,
                  ),
                  textAlign: TextAlign.center, // 🔹 Asegura centrado del texto
                ),
              ],
            ),
          ),

          // Lista de reservas
          Expanded(
            child: ListView.builder(
              itemCount: listareservas.length,
              itemBuilder: (context, index) {
                final Reserva reserva = listareservas[index];

                return Card(
                  color: Colors.white,
                  elevation: 3,
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    tileColor: Colors.white,
                    title: Text(
                      'Reserva # ${reserva.id_reserva}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${getEstado(reserva.id_estado)}'),
                        Text('${reserva.fecha.toLocal()}'),
                      ],
                    ),
                    trailing: Icon(
                      getEstadoIcon(reserva.id_estado),
                      color: AppColors.mainColor,
                      size: 30,
                    ),
                  ),
                );
              },
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
