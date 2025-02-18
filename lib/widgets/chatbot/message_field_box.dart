import 'package:flutter/material.dart';
import 'package:food_hub/utils/colors.dart';

class MessageFieldBox extends StatelessWidget {

  // ValueChanged: callback que emite o retorna un valor.
  // justamente el método de sendMessaje por dentro emite ese cambio mediante el notifyListeners()
  // esto para que el widget de lista de mensajes se actualice y renderice el mensaje nuevo.
  final ValueChanged<String> onValue;

  const MessageFieldBox({super.key, required this.onValue});

  @override
  Widget build(BuildContext context) {
    // elemento que da control sobre el input al que lo asociemos
    final textController = TextEditingController();
    // para mantener el foco dentro de un elemento que tenga la propiedad focusNode
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

    // 
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
        // exactamente en este evento el clear quita el foco y se quita el teclado,
        // pero usando el boton esto no pasa, por eso usamos el requestFocus()
        // print('Submit value $value'); // al enviar, que se activa con un enter
        textController.clear(); // limpiamos la caja de texto con el controles
        focusNode.requestFocus(); // el foco lo mantenemos en la claja de texto, porque el clear lo quita
        onValue(value); // llamamos al método que recibimos
      },
      // onChanged: (value){
      //   print("changed $value"); // cambio en el contenido del textform
      // },
    );
  }
}