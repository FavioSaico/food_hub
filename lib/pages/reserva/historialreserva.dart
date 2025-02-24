import 'package:flutter/material.dart';
import 'package:food_hub/domain/reserva.dart';
import 'package:food_hub/pages/reserva/detallenuevo.dart';
import 'package:food_hub/widgets/empty_list.dart';
import 'package:provider/provider.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/providers/reserva_provider.dart';
import 'package:food_hub/providers/auth_provider.dart';
import 'package:intl/intl.dart';

class HistorialReservasPage extends StatefulWidget {
  const HistorialReservasPage({super.key});

  @override
  _HistorialReservasPageState createState() => _HistorialReservasPageState();
}

class _HistorialReservasPageState extends State<HistorialReservasPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = authProvider.currentUser?.id;
      if (userId != null) {
        Provider.of<ReserveProvider>(context, listen: false)
            .getListReserveUser(userId);
      }
    });
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
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white),
          style: IconButton.styleFrom(backgroundColor: AppColors.mainColor),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Mi Historial de Reservas",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.mainColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<ReserveProvider>(
        builder: (context, provider, child) {
          if (provider.reservations.isEmpty) {
            return EmptyList(message: "No tienes reservas registradas");
          }
          
          final sortedReservations = List.from(provider.reservations);
            // ..sort((a, b) => a.id_reserva.compareTo(b.id_reserva));

          return ListView.builder(
            itemCount: sortedReservations.length,
            itemBuilder: (context, index) {
              final Reserva reserva = sortedReservations[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  tileColor: Colors.white,
                  title: Text(
                    'Reserva # ${(reserva.id_reserva > 0 && reserva.id_reserva <= 9) ? "00": (reserva.id_reserva > 9 ? "0" : "")}${reserva.id_reserva} - ${reserva.sede_nombre}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reserva.estado_nombre ?? 'Estado desconocido',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.mainColor,
                        ),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy - HH:mm').format(reserva.fecha),
                        style: const TextStyle(color: Colors.black54),
                      ),
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
                        allowSnapshotting: false,
                        builder: (context) => DetalleReservaScreen(reservaId: reserva.id_reserva),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: AppMenu(selectedIndex: 3),
    );
  }
}