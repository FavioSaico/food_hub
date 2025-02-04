import 'package:flutter/material.dart';

class ZonaPreferidaWidget extends StatefulWidget {
  @override
  _ZonaPreferidaWidgetState createState() => _ZonaPreferidaWidgetState();
}

class _ZonaPreferidaWidgetState extends State<ZonaPreferidaWidget> {
  String _zonaSeleccionada = 'Terraza'; // Zona inicial
  String _imagenReferencial = 'assets/imagenes/terraza.png'; // Imagen inicial

  final Map<String, String> _imagenes = {
    'Terraza': 'assets/imagenes/terraza.png',
    'Salón Principal': 'assets/imagenes/salon-principal.png',
    'Barra': 'assets/imagenes/barra.png',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Zona Preferida:', style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
        Image.asset(_imagenReferencial, height: 200), // Imagen referencial
        SizedBox(height: 10),
        DropdownButton<String>(
          value: _zonaSeleccionada,
          items: _imagenes.keys.map((String zona) {
            return DropdownMenuItem<String>(
              value: zona,
              child: Text(zona),
            );
          }).toList(),
          onChanged: (String? nuevaZona) {
            if (nuevaZona != null) {
              setState(() {
                _zonaSeleccionada = nuevaZona;
                _imagenReferencial = _imagenes[nuevaZona]!;
              });
            }
          },
        ),
      ],
    );
  }
}
