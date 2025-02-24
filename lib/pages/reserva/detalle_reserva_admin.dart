import 'package:flutter/material.dart';
import 'package:food_hub/domain/estadoreserva.dart';
import 'package:food_hub/domain/reserva.dart';
import 'package:food_hub/pages/user/admin_reservas.dart';
import 'package:food_hub/providers/shared_provider.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/widgets/error_message.dart';
import 'package:intl/intl.dart';
import 'package:food_hub/providers/reserva_provider.dart';
import 'package:provider/provider.dart';

class DetalleReservaAdminScreen extends StatefulWidget {
  final int reservaId;

  const DetalleReservaAdminScreen({super.key, required this.reservaId});

  @override
  _DetalleReservaAdminScreenState createState() => _DetalleReservaAdminScreenState();
}

class _DetalleReservaAdminScreenState extends State<DetalleReservaAdminScreen> {
  Reserva? reserva;
  bool isLoading = true;
  int? selectedValue = 1;

  List<Estado> opciones = [];

  @override
  void initState() {
    super.initState();
    _fetchReserva();
  }

  Future<void> _fetchReserva() async {
    final provider = Provider.of<ReserveProvider>(context, listen: false);
    final fetchedReserva = await provider.getReserveById(widget.reservaId);
    
    await Provider.of<SharedProvider>(context, listen: false).getStates();
    opciones = Provider.of<SharedProvider>(context, listen: false).estadosList;
    opciones = opciones.where((Estado e ){ return e.tipo != "Enviado";}).toList();

    selectedValue = fetchedReserva?.id_estado ?? 1;
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
        centerTitle: true,
        title: Text(
          "Detalle de Reserva",
          style: TextStyle(color: AppColors.mainColor, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(color: AppColors.mainColor, backgroundColor: Colors.white),
            )
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
                        // const SizedBox(height: 16), // Espaciado
                        _buildSelectState(),
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
              Text("Reserva", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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

  Widget _buildSelectState() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Text("Cambiar estado:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(width: 20),

              opciones.isNotEmpty ? DropdownButton<int>(
                icon: Icon(Icons.keyboard_arrow_down, color: AppColors.mainColor, size: 30),
                borderRadius: BorderRadius.circular(10),
                isExpanded: false,
                value: selectedValue,
                onChanged: (int? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                underline: Container(height: 1, color: Colors.black),
                items: opciones.map((value) {
                  return DropdownMenuItem<int>(
                    value: value.id,
                    child: Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Text(value.tipo),
                    ),
                  );
                }).toList(),
              )
              : Center(child: CircularProgressIndicator(color: AppColors.mainColor, backgroundColor: Colors.white,))
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: selectedValue != reserva!.id_estado ? () {
                  Navigator.pop(context);
                }
                : null,
                child: const Text('Cancelar', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor),
                  onPressed: selectedValue != reserva!.id_estado ? () async {
                    if (reserva != null) {
                      final provider = Provider.of<ReserveProvider>(context, listen: false);
                      await provider.updateReserveState(reserva!.id_reserva, selectedValue!);
                
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Estado actualizado con éxito")),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => AdminReservasPage()),
                      );
                      // Navigator.pop(context); // Cerrar la pantalla después de guardar
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Por favor selecciona un estado")),
                      );
                    }
                  }
                  : null,
                child: const Text('Guardar', style: TextStyle(color: Colors.white, fontSize: 16)),
              ), 
            ],
          ),
        ],
      ),
    );
  }
}