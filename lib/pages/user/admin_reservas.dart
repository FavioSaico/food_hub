import 'package:flutter/material.dart';
import 'package:food_hub/utils/date.dart';
import 'package:provider/provider.dart';
import 'package:food_hub/domain/reserva.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/providers/reserva_provider.dart';
import 'package:food_hub/pages/reserva/detalle_reserva_admin.dart';

class AdminReservasPage extends StatefulWidget {
  const AdminReservasPage({super.key});

  @override
  _AdminReservasPageState createState() => _AdminReservasPageState();
}

class _AdminReservasPageState extends State<AdminReservasPage> {
  String _selectedSede = "San Isidro";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReserveProvider>(context, listen: false).fetchReservations();
    });
  }

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
        automaticallyImplyLeading: false,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: DropdownButton<String>(
              value: _selectedSede,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSede = newValue!;
                });
              },
              items: ["San Isidro", "San Borja"].map((String sede) {
                return DropdownMenuItem<String>(
                  value: sede,
                  child: Text(
                    sede,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Consumer<ReserveProvider>(
              builder: (context, provider, child) {
                int sedeFiltro = _selectedSede == "San Isidro" ? 1 : 2;
                List<Reserva> reservasFiltradas = provider.reservations
                    .where((reserva) => reserva.id_sede == sedeFiltro)
                    .toList();
                
                if (reservasFiltradas.isEmpty) {
                  return Center(
                    child: Text(
                      "No hay reservas registradas para $_selectedSede",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  );
                }
                
                return ListView.builder(
                  itemCount: reservasFiltradas.length,
                  itemBuilder: (context, index) {
                    final Reserva reserva = reservasFiltradas[index];
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
                          'Reserva # ${(reserva.id_reserva > 0 && reserva.id_reserva <= 9) ? "00": (reserva.id_reserva > 9 ? "0" : "")}${reserva.id_reserva}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(getEstado(reserva.id_estado),style: TextStyle(color: AppColors.mainColor),),
                            Text(AppDate.formateoFechaSimple(reserva.fecha)),
                          ],
                        ),
                        trailing: Icon(
                          getEstadoIcon(reserva.id_estado),
                          color: AppColors.mainColor,
                          size: 30,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalleReservaAdminScreen(
                                reservaId: reserva.id_reserva,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
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
