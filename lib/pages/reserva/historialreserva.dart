import 'package:flutter/material.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/widgets/app_icon.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/widgets/big_text.dart';
import 'package:food_hub/widgets/bold_normal_text.dart';
import 'package:food_hub/widgets/build_menu_option.dart';
import 'package:food_hub/utils/dimensions.dart';
import 'package:food_hub/providers/reserva_provider.dart';
import 'package:provider/provider.dart';
import 'package:food_hub/domain/estadoreserva.dart';
import 'package:food_hub/pages/user/admin_reservas.dart';

class HistorialReservasPage extends StatefulWidget {
  const HistorialReservasPage({super.key});
  @override
  _HistorialReservasPageState createState() => _HistorialReservasPageState();
}

class _HistorialReservasPageState extends State<HistorialReservasPage> {
  @override
  void initState() {
    super.initState();
    // Llama al método para cargar las reservas del usuario
    final provider = Provider.of<ReserveProvider>(context, listen: false);
    provider
        .fetchReservations(); // Se usa fetchReservations para obtener todas las reservas y filtrar las del usuario
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                    const SizedBox(height: 15),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        "Mi Historial de Reservas",
                        style: TextStyle(
                          fontSize: 24,
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

          // Lista de reservas del usuario
          Expanded(
            child: Consumer<ReserveProvider>(
              builder: (context, provider, child) {
                final userReservations = provider.reservations
                    .where((reserva) =>
                        reserva.id_usuario ==
                        1) // Reemplaza '1' con el ID del usuario actual
                    .toList();

                if (userReservations.isEmpty) {
                  return Center(child: Text("No tienes reservas."));
                }

                return ListView.builder(
                  itemCount: userReservations.length,
                  itemBuilder: (context, index) {
                    final reserva = userReservations[index];
                    final estado = provider.states.firstWhere(
                        (state) => state.id_estado == reserva.id_estado,
                        orElse: () => EstadoReserva(
                            id_estado: 0, tipo_estado: "Desconocido"));

                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text('Reserva # ${reserva.id_reserva}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Fecha: ${reserva.fecha.toLocal()}'),
                            Text('Estado: ${estado.tipo_estado}'),
                          ],
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
        children: [
          AppMenu(),
        ],
      ),
    );
  }
}
