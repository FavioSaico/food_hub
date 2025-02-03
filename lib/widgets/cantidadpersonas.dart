import 'package:flutter/material.dart';

class CantidadPersonasSelector extends StatefulWidget {
  @override
  _CantidadPersonasSelectorState createState() =>
      _CantidadPersonasSelectorState();
}

class _CantidadPersonasSelectorState extends State<CantidadPersonasSelector> {
  int _cantidad = 1; // Valor inicial, mínimo 1 persona

  void _incrementar() {
    if (_cantidad < 20) {
      setState(() {
        _cantidad++;
      });
    }
  }

  void _disminuir() {
    if (_cantidad > 1) {
      setState(() {
        _cantidad--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Texto "Cantidad de personas"
          Text(
            "Cantidad de personas:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 10), // Espacio entre el texto y el selector

          // Selector de cantidad de personas
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Botón de restar (-)
              IconButton(
                onPressed: _disminuir,
                icon: Icon(Icons.remove, color: Colors.white),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                ),
              ),

              // Número de personas con un SizedBox para fijar el ancho
              Container(
                width: 40, // Puedes ajustar el ancho si es necesario
                alignment: Alignment.center,
                child: Text(
                  '$_cantidad',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              // Botón de sumar (+)
              IconButton(
                onPressed: _incrementar,
                icon: Icon(Icons.add, color: Colors.white),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
