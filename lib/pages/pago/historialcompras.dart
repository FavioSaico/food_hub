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

class HistorialComprasPage extends StatefulWidget {
  const HistorialComprasPage({super.key});

  @override
  _HistorialComprasPageState createState() => _HistorialComprasPageState();
}

class _HistorialComprasPageState extends State<HistorialComprasPage> {
  late Future<List<Compra>> _futureCompras;
  final int userId = 1; // Aquí deberías obtener el ID del usuario autenticado

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<CompraProvider>(context, listen: false);
    _futureCompras = provider.getListPurchasesByUser(userId);
    provider.fetchStates(); // Carga los estados de compra
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
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      "Mis Compras",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ],
            ),
          ),

          // Lista de compras del usuario
          Expanded(
            child: FutureBuilder<List<Compra>>(
              future: _futureCompras,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error al cargar compras"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("No hay compras registradas"));
                }

                final compras = snapshot.data!;
                return ListView.builder(
                  itemCount: compras.length,
                  itemBuilder: (context, index) {
                    final compra = compras[index];
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text('Compra # ${compra.id}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Fecha: ${compra.fecha}'),
                            Text(
                              'Estado: ${compra.estado.tipo}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
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
