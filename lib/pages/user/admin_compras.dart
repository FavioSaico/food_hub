import 'package:flutter/material.dart';
import 'package:food_hub/domain/compras_historial.dart';
import 'package:food_hub/providers/compra_provider.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/utils/dimensions.dart';
import 'package:provider/provider.dart';

class AdminComprasPage extends StatefulWidget {
  const AdminComprasPage({super.key});
  @override
  _AdminComprasPageState createState() => _AdminComprasPageState();
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

class _AdminComprasPageState extends State<AdminComprasPage> {
  @override
  void initState() {
    super.initState();
  }

  List<CompraHistorial> listacompras = [
    CompraHistorial(
      id_compra: 1,
      fecha: DateTime.now(),
      id_estado: 1,
      costoTotal: 10,
    ),
    CompraHistorial(
      id_compra: 2,
      fecha: DateTime.now(),
      id_estado: 2,
      costoTotal: 20,
    ),
    CompraHistorial(
      id_compra: 3,
      fecha: DateTime.now(),
      id_estado: 3,
      costoTotal: 30,
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
                  "Historial de compras",
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

          // Lista de compras
          Expanded(
            child: ListView.builder(
              itemCount: listacompras.length,
              itemBuilder: (context, index) {
                final CompraHistorial compra = listacompras[index];
                return Card(
                  color: Colors.white,
                  elevation: 3,
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      'Compra # ${compra.id_compra}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${getEstado(compra.id_estado)}',
                        ),
                        Text('${compra.fecha}'),
                      ],
                    ),
                    trailing: Icon(
                      getEstadoIcon(compra.id_estado),
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
