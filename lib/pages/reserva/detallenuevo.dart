import 'package:flutter/material.dart';
import 'package:food_hub/domain/reserva.dart';
import 'package:food_hub/utils/colors.dart';
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
      appBar: AppBar(
        title: const Text(
          "Detalle de reserva",
          style: TextStyle(color: Color(0xFF5CABA1)),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF5CABA1)),
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : reserva == null
              ? const Center(child: Text("No se encontró la reserva."))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildReservaInfo(),
                      const SizedBox(height: 16),
                      _buildEstado(),
                    ],
                  ),
                ),
    );
  }

  Widget _buildReservaInfo() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
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
