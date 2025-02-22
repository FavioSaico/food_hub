import 'package:flutter/material.dart';
import 'package:food_hub/utils/colors.dart';

class MessageFieldBox extends StatelessWidget {

  // ValueChanged: callback que emite o retorna un valor.
  // justamente el método de sendMessaje por dentro emite ese cambio mediante el notifyListeners()
  final ValueChanged<String> onValue;

  const MessageFieldBox({super.key, required this.onValue});

  @override
  Widget build(BuildContext context) {

    final textController = TextEditingController();
    final focusNode = FocusNode(); 

    // creamos esa variable para guardar la configuraciones de los bordes
    final outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide(width:1, color: const Color.fromARGB(255, 189, 189, 189)),
        borderRadius: BorderRadius.circular(25),
    );

    // variable para guardar la configuración del input
    final inputDecoration = InputDecoration(
      hintText: 'Escribe un mensaje',
      hintStyle: TextStyle(color: const Color.fromARGB(255, 168, 168, 168)),
      // colocamos los mismos estilos de borde
      border: outlineInputBorder,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      fillColor: Colors.white,
      filled: true,
      suffixIcon: IconButton( // colocamos el icono para el envio de mensajes
        icon: Icon(Icons.send, color: AppColors.mainColor),
        onPressed: () {
          final textValue = textController.value.text; // obtenemos el texto
          textController.clear();
          onValue(textValue); // llamamos la método que recibimos por parámetro
        },
      ),
    );

    return TextFormField(
      // cuando presionamos fuera de la caja de texto quitamos el foco
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      focusNode: focusNode, // colocamos el foco
      controller: textController, // colocamos el controlador
      decoration: inputDecoration,
      style: TextStyle(
        backgroundColor: Colors.white
      ),
      onFieldSubmitted: (value) {
        textController.clear(); // limpiamos la caja de texto con el controles
        focusNode.requestFocus(); // el foco lo mantenemos en la claja de texto, porque el clear lo quita
        onValue(value); // llamamos al método que recibimos
      },
    );
  }
}