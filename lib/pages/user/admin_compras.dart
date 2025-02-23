import 'package:flutter/material.dart';
import 'package:food_hub/domain/compra_historial.dart';
import 'package:food_hub/providers/compra_provider.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/widgets/empty_list.dart';
import 'package:food_hub/widgets/error_message.dart';
import 'package:food_hub/widgets/item_compra_list.dart';
import 'package:intl/intl.dart';
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
    _obtenetListaCompras();
  }

  List<HistorialCompra> listaCompras = [];
  MessageResponseCompraProvider<List<HistorialCompra>>? response;
  bool _isLoading = false;
  bool _isSuccessful = true;
  String _selectedSede = "San Isidro"; // Opción predeterminada

  Future<void> _obtenetListaCompras() async {
    setState(() => _isLoading = true); 
    response = await Provider.of<CompraProvider>(context, listen: false).getListPurchases();
    _isSuccessful = response!.isSuccessful;
    listaCompras = response!.data ?? [];
    setState(() => _isLoading = false);
  }

  // Método para formatear la fecha
  String formateoFecha(DateTime date) {
    String formattedDateTime = DateFormat('EEEE d MMMM y - HH:mm', 'es_ES').format(date);
    return '${formattedDateTime[0].toUpperCase()}${formattedDateTime.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    // Filtrar la lista de compras según la sede seleccionada
    int sedeFiltro = _selectedSede == "San Isidro" ? 1 : 2;
    List<HistorialCompra> comprasFiltradas =
        listaCompras.where((compra) => compra.sede.idSede == sedeFiltro).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Lista de Compras",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.mainColor),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Dropdown para seleccionar la sede
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
          // Lista de compras con el filtro aplicado
          _isLoading
              ? SizedBox(height: 100, child: Center(child: CircularProgressIndicator(color: AppColors.mainColor, backgroundColor: Colors.white)))
              : _isSuccessful
                  ? comprasFiltradas.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: comprasFiltradas.length,
                            itemBuilder: (context, index) {
                              final HistorialCompra compra = comprasFiltradas[index];
                              return ItemCompraList(compra: compra);
                            },
                          ),
                        )
                      : EmptyList(message: "No hay compras registradas para $_selectedSede")
                  : ErrorMessage(message: response!.message),
        ],
      ),
      bottomNavigationBar: AppMenu(selectedIndex: 2),
    );
  }
}
