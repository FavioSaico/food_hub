import 'package:flutter/material.dart';
import 'package:food_hub/domain/compra_registro.dart';
import 'package:food_hub/pages/pago/Pagorealizado.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter/services.dart';
import 'package:food_hub/widgets/app_menu.dart';

class RegisterCard extends StatelessWidget {

  final CompraRegistro compra;
  const RegisterCard({super.key, required this.compra});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.mainColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Agregar tarjeta",
          style: TextStyle(color: AppColors.mainColor, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "REGISTRE LOS DATOS DE SU TARJETA DE CRÉDITO/DÉBITO",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(
                width: 300,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/imagenes/DATOS_TARJETA.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.error, color: Colors.red, size: 50),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildCardNumberField(), // Número de tarjeta con formato
              const SizedBox(height: 10),
              _buildExpiryDateField(),  // Mes y Año con formato
              const SizedBox(height: 10),
              _buildCVCField(),         // CVC limitado a 3 dígitos
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      allowSnapshotting: false,
                      builder: (context) => PagoRealizadoPage(compra: compra),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Pagar",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppMenu(selectedIndex: 2),
    );
  }

  // Campo para el número de tarjeta con formato XXXX-XXXX-XXXX-XXXX
  Widget _buildCardNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Número de tarjeta", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 5),
        TextField(
          keyboardType: TextInputType.number,
          inputFormatters: [CreditCardNumberInputFormatter()],
          decoration: InputDecoration(
            hintText: 'XXXX-XXXX-XXXX-XXXX',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          ),
        ),
      ],
    );
  }

  // Campo para Mes y Año con formato MM/AAAA
  Widget _buildExpiryDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Mes y Año", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 5),
        TextField(
          keyboardType: TextInputType.datetime,
          inputFormatters: [MaskedInputFormatter('##/####')],
          decoration: InputDecoration(
            hintText: 'MM/AAAA',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          ),
        ),
      ],
    );
  }

  // Campo para CVC con máximo de 3 dígitos y texto oculto
  Widget _buildCVCField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("CVC", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 5),
        TextField(
          keyboardType: TextInputType.number,
          obscureText: true,
          inputFormatters: [LengthLimitingTextInputFormatter(3)],
          decoration: InputDecoration(
            hintText: '***',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          ),
        ),
      ],
    );
  }
}
