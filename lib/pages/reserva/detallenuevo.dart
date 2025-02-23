import 'package:flutter/material.dart';
import 'package:food_hub/domain/reserva.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/widgets/error_message.dart';
import 'package:intl/intl.dart';
import 'package:food_hub/providers/reserva_provider.dart';
import 'package:provider/provider.dart';

class DetalleReservaScreen extends StatefulWidget {
  final int reservaId;

  const DetalleReservaScreen({super.key, required this.reservaId});

  @override
  _DetalleReservaScreenState createState() => _DetalleReservaScreenState();
}

class _DetalleReservaScreenState extends State<DetalleReservaScreen> {
  Reserva? reserva;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchReserva();
  }

  Future<void> _fetchReserva() async {
    final provider = Provider.of<ReserveProvider>(context, listen: false);
    final fetchedReserva = await provider.getReserveById(widget.reservaId);
    
    if (mounted) {
      setState(() {
        reserva = fetchedReserva;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.mainColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Detalle de reserva",
          style: TextStyle(color: AppColors.mainColor),
        ),
        backgroundColor: Colors.white,
        // iconTheme: IconThemeData(color: AppColors.mainColor),
        elevation: 0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: AppColors.mainColor, backgroundColor: Colors.white,))
          : reserva == null
              ? ErrorMessage(message: "No se encontró la reserva.")
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildReservaInfo(),
                        const SizedBox(height: 16),
                        _buildEstado(),
                      ],
                    ),
                  ),
                ),
      bottomNavigationBar: AppMenu(selectedIndex: 3),
    );
  }

  Widget _buildReservaInfo() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Reserva",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 4),
              _buildDetailText("Día:", DateFormat('dd/MM/yyyy').format(reserva!.fecha)),
              _buildDetailText("Hora:", DateFormat('HH:mm').format(reserva!.fecha)),
              _buildDetailText("Cantidad de personas:", "${reserva!.cantidad_personas} persona(s)"),
              _buildDetailText("Zona preferida:", reserva!.zona_nombre ?? "No especificada"),
              _buildDetailText("Requerimientos especiales:", reserva!.detalle ?? "Ninguno"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEstado() {
    return RichText(
      text: TextSpan(
        text: "Estado: ",
        style: const TextStyle(fontSize: 16, color: Colors.black),
        children: [
          TextSpan(
            text: reserva!.estado_nombre,
            style: TextStyle(color: AppColors.mainColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailText(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          text: "$title ",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
