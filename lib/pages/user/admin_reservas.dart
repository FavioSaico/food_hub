import 'package:flutter/material.dart';
import 'package:food_hub/domain/reserva.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/widgets/app_menu.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading:false,
        // leading: IconButton(
        //   icon: const Icon(Icons.chevron_left, color: Colors.white),
        //   style: IconButton.styleFrom(backgroundColor: AppColors.mainColor),
        //   onPressed: () => Navigator.pop(context),
        // ),
        centerTitle: true,
        title: Text(
          "Lista de reservas",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.mainColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
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
                        Text(getEstado(reserva.id_estado)),
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
      bottomNavigationBar: AppMenu(selectedIndex: 1),
    );
  }
}
