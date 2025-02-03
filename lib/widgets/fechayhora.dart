import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatear fecha y hora

class FechaHoraSelector extends StatefulWidget {
  @override
  _FechaHoraSelectorState createState() => _FechaHoraSelectorState();
}

class _FechaHoraSelectorState extends State<FechaHoraSelector> {
  DateTime? selectedDate;
  String selectedTime = "Seleccionar hora";

  // Método para mostrar el selector de fecha
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate:
          DateTime.now().add(Duration(days: 365)), // Un año hacia adelante
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Método para mostrar el selector de hora
  void _selectTime(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          child: ListView.builder(
            itemCount: 9, // Horas desde 12:00 hasta 20:00
            itemBuilder: (context, index) {
              int hour = 12 + index;
              String time = "$hour:00 Hrs";
              return ListTile(
                title: Text(time),
                onTap: () {
                  setState(() {
                    selectedTime = time;
                  });
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Seleccione Fecha y Hora",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Color(0xFF6EC6A7), // Color de fondo
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              // Botón de Fecha
              Expanded(
                child: InkWell(
                  onTap: () => _selectDate(context),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_today, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          selectedDate != null
                              ? DateFormat('MMMM, d').format(selectedDate!)
                              : "Seleccionar fecha",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(Icons.arrow_drop_down, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
              // Línea Divisoria
              Container(width: 1, height: 40, color: Colors.white),
              // Botón de Hora
              Expanded(
                child: InkWell(
                  onTap: () => _selectTime(context),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.access_time, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          selectedTime,
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(Icons.arrow_drop_down, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
