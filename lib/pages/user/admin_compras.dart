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

  Future<void> _obtenetListaCompras() async {
    setState(() => _isLoading = true);
    response = await Provider.of<CompraProvider>(context, listen: false).getListPurchases();
    _isSuccessful = response!.isSuccessful;
    listaCompras = response!.data ?? [];
    setState(() => _isLoading = false);
  }

  String formateoFecha( DateTime date) {
    String formattedDateTime = DateFormat('EEEE d MMMM y - HH:mm', 'es_ES').format(date);
    return '${formattedDateTime[0].toUpperCase()}${formattedDateTime.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading:false,
        // leading: IconButton(
        //   icon: const Icon(Icons.chevron_left, color: Colors.white),
        //   style: IconButton.styleFrom(
        //     backgroundColor: AppColors.mainColor,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        centerTitle: true,
        title: SizedBox(
          child: Text(
            "Lista de Compras",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.mainColor,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Lista de compras con el costo total en lugar del icono
          _isLoading
          ? SizedBox(height: 100, child: Center(child: CircularProgressIndicator(color: AppColors.mainColor, backgroundColor: Colors.white,)))
          : _isSuccessful
            ? listaCompras.isNotEmpty 
              ? Expanded(
                child: ListView.builder(
                  itemCount: listaCompras.length,
                  itemBuilder: (context, index) {
                    final HistorialCompra compra = listaCompras[index];
                    return ItemCompraList(compra: compra);
                  },
                ),
              )
              : EmptyList(message: "No hay compras registradas")
            : ErrorMessage(message: response!.message)
        ],
      ),
      bottomNavigationBar: AppMenu(selectedIndex: 2),
    );
  }
}
