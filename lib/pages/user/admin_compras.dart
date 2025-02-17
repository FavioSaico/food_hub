import 'package:flutter/material.dart';
import 'package:food_hub/providers/compra_provider.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/widgets/app_icon.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/widgets/big_text.dart';
import 'package:food_hub/widgets/bold_normal_text.dart';
import 'package:food_hub/widgets/build_menu_option.dart';
import 'package:food_hub/utils/dimensions.dart';
import 'package:food_hub/providers/reserva_provider.dart';
import 'package:provider/provider.dart';

class AdminComprasPage extends StatefulWidget {
  const AdminComprasPage({super.key});
  @override
  _AdminComprasPageState createState() => _AdminComprasPageState();
}

class _AdminComprasPageState extends State<AdminComprasPage> {
  @override
  void initState() {
    super.initState();
    // Llama al método para cargar los estados de las compras
    final provider = Provider.of<CompraProvider>(context, listen: false);
    provider
        .fetchStates(); // Asegúrate de que este método exista en tu provider
    provider.getListPurchases(); // Llamamos a obtener las compras
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
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
                        "Historial de compras ",
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

          // Lista de compras
          Expanded(
            child: Consumer<CompraProvider>(
              // Usamos Consumer para escuchar cambios
              builder: (context, provider, child) {
                // Cargando datos
                if (provider.reservations.isEmpty || provider.states.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: provider.reservations.length,
                  itemBuilder: (context, index) {
                    final reserva = provider.reservations[index];
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text('Reserva # ${reserva.id}'),
                        subtitle: Text('${reserva.fecha}'),
                        trailing: DropdownButton<int>(
                          value:
                              reserva.estado.id, // El valor actual del estado
                          items: provider.states.map((state) {
                            return DropdownMenuItem<int>(
                              value: state.id,
                              child: Text(state.tipo),
                            );
                          }).toList(),
                          onChanged: (newValue) async {
                            if (newValue != null) {
                              // Actualizamos el estado de la reserva
                              await provider.updateReserveState(
                                  reserva.id, newValue);
                            }
                          },
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
