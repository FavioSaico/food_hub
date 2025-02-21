import 'package:flutter/material.dart';
import 'package:food_hub/domain/compra_historial.dart';
import 'package:food_hub/providers/auth_provider.dart';
import 'package:food_hub/providers/compra_provider.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/widgets/item_compra_list.dart';
import 'package:provider/provider.dart';

class HistorialComprasPage extends StatefulWidget {
  const HistorialComprasPage({super.key});

  @override
  _HistorialComprasPageState createState() => _HistorialComprasPageState();
}

class _HistorialComprasPageState extends State<HistorialComprasPage> {
  @override
  void initState() {
    super.initState();
    _obtenetListaCompras();
  }

  List<HistorialCompra> historialCompras = [];
  MessageResponseCompraProvider<List<HistorialCompra>>? response;
  bool _isLoading = false;
  bool _isSuccessful = true;

  Future<void> _obtenetListaCompras() async {
    setState(() => _isLoading = true);
    int idUser = Provider.of<AuthProvider>(context, listen: false).currentUser!.id;
    response = await Provider.of<CompraProvider>(context, listen: false).getListPurchasesByUser(idUser);
    _isSuccessful = response!.isSuccessful;
    historialCompras = response!.data ?? [];
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: SizedBox(
          child: Text(
            "Mis Compras",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.mainColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Lista de compras con el costo total en lugar del icono
          _isLoading
          ? CircularProgressIndicator(color: AppColors.mainColor, backgroundColor: Colors.white,)
          : _isSuccessful
            ? Expanded(
              child: ListView.builder(
                // reverse: true,
                itemCount: historialCompras.length,
                itemBuilder: (context, index) {
                  final HistorialCompra compra = historialCompras[index];
                  return ItemCompraList(compra: compra);
                },
              ),
            )
            : const SizedBox(height: 0)
        ],
      ),
      bottomNavigationBar: AppMenu(),
    );
  }
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

