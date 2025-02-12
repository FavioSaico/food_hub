import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatear fecha y hora

class FechaHoraSelector extends StatefulWidget {
  final Function(DateTime, String) onFechaHoraSeleccionada;

  const FechaHoraSelector({Key? key, required this.onFechaHoraSeleccionada})
      : super(key: key);

  @override
  _FechaHoraSelectorState createState() => _FechaHoraSelectorState();
}

class _FechaHoraSelectorState extends State<FechaHoraSelector> {
  DateTime? selectedDate;
  String selectedTime = "Seleccionar hora";

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      if (selectedDate != null) {
        widget.onFechaHoraSeleccionada(selectedDate!, selectedTime);
      }
    }
  }

  void _selectTime(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          child: ListView.builder(
            itemCount: 9,
            itemBuilder: (context, index) {
              int hour = 12 + index;
              String time = "$hour:00 Hrs";
              return ListTile(
                title: Text(time),
                onTap: () {
                  setState(() {
                    selectedTime = time;
                  });
                  if (selectedDate != null) {
                    widget.onFechaHoraSeleccionada(selectedDate!, selectedTime);
                  }
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Seleccione Fecha y Hora",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10), // Espacio entre el texto y el selector

          // Selector de fecha
          InkWell(
            onTap: () => _selectDate(context),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.calendar_today, color: Colors.white),
                  Text(
                    selectedDate != null
                        ? DateFormat('MMMM d, yyyy').format(selectedDate!)
                        : "Seleccionar fecha",
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
            ),
          ),

          SizedBox(height: 15), // Espacio entre fecha y hora

          // Selector de hora
          InkWell(
            onTap: () => _selectTime(context),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.access_time, color: Colors.white),
                  Text(
                    selectedTime,
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
