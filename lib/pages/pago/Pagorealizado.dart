import 'package:flutter/material.dart';
import 'package:food_hub/domain/compra_registro.dart';
import 'package:food_hub/providers/cart_provider.dart';
import 'package:food_hub/providers/compra_provider.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:provider/provider.dart';

class PagoRealizadoPage extends StatefulWidget {
  final CompraRegistro compra;

  const PagoRealizadoPage({super.key, required this.compra});

  @override
  State<PagoRealizadoPage> createState() => _PagoRealizadoPageState();
}

class _PagoRealizadoPageState extends State<PagoRealizadoPage> {

  MessageResponseCompraProvider<int>? response;
  bool _isLoading = false;
  bool _isSuccessful = true;
  int idCompra = 0;

  Future<void> _registrarCompra() async {
    setState(() => _isLoading = true);
    response = await Provider.of<CompraProvider>(context, listen: false).registerCompra(compra: widget.compra);
    _isSuccessful = response!.isSuccessful;
    idCompra = response!.data ?? 0;
    if (_isSuccessful) Provider.of<CartProvider>(context, listen: false).clear();
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _registrarCompra();
  }



  @override
  Widget build(BuildContext context) {
    return _isLoading
    ? Scaffold(backgroundColor: Colors.white, body: Center(child: CircularProgressIndicator(color: AppColors.mainColor, backgroundColor: Colors.white,)))
    : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if(_isSuccessful){
              Navigator.pushNamed(context, '/');
            }else{
              Navigator.pop(context);
            }
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _isSuccessful
              ? Image.asset('assets/imagenes/Compra_realizadaC.png', height: 150)
              : Icon(Icons.cancel,color: Colors.deepOrange, size: 60,),
              const SizedBox(height: 20),
              
              Text(
                response!.message,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 10),

              _isSuccessful 
              ? Column(
                  children: [
                    Text(
                      "Compra # ${(idCompra > 0 && idCompra <= 9) ? "00": (idCompra > 9 ? "0" : "")}$idCompra",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "S/. ${widget.compra.costoTotal.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                  ],
                )
              : const SizedBox(height: 0),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2CAA97),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text(
                  "Ir al home",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}