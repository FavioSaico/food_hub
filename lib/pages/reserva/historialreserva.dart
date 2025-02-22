import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_hub/domain/reserva.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/utils/dimensions.dart';
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
      final usuario = authProvider.currentUser;
      final userId = usuario?.id;
      if (userId != null) {
        Provider.of<ReserveProvider>(context, listen: false)
            .getListReserveUser(userId);
      }
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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: Dimensions.height60, bottom: Dimensions.height15),
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    "Mi Historial de Reservas",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<ReserveProvider>(
              builder: (context, provider, child) {
                if (provider.reservations.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                // Ordenar las reservas por id_reserva de menor a mayor
                List<Reserva> sortedReservations = List.from(provider.reservations)
                  ..sort((a, b) => a.id_reserva.compareTo(b.id_reserva));

                return ListView.builder(
                  itemCount: sortedReservations.length,
                  itemBuilder: (context, index) {
                    final Reserva reserva = sortedReservations[index];
                    final int orden = index + 1; // Número de orden dinámico
                    
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        tileColor: Colors.white,
                        title: Text(
                          'Reserva #$orden - ${reserva.sede_nombre}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reserva.estado_nombre ?? 'Estado desconocido',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.mainColor),
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy - HH:mm').format(reserva.fecha),
                              style:
                                  const TextStyle(color: Colors.black54),
                            ),
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
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [AppMenu()],
      ),
    );
  }
}
