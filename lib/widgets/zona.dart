import 'package:flutter/material.dart';

class ZonaPreferidaWidget extends StatefulWidget {
  final Function(String) onZonaSeleccionada;

  const ZonaPreferidaWidget({Key? key, required this.onZonaSeleccionada})
      : super(key: key);

  @override
  _ZonaPreferidaWidgetState createState() => _ZonaPreferidaWidgetState();
}

class _ZonaPreferidaWidgetState extends State<ZonaPreferidaWidget> {
  String _zonaSeleccionada = 'Terraza';
  String _imagenReferencial = 'assets/imagenes/terraza.png';

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
        // Centrar la imagen
        Center(
          child: Image.asset(
            _imagenReferencial,
            height: 200,
            fit: BoxFit
                .cover, // Ajusta la imagen para que ocupe el espacio disponible sin perder proporciones
          ),
        ),
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
              widget.onZonaSeleccionada(nuevaZona);
            }
          },
        ),
      ],
    );
  }
}
