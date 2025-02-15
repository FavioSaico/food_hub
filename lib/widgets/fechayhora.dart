import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatear fecha y hora

class FechaHoraSelector extends StatefulWidget {
  final Function(DateTime) onFechaHoraSeleccionada;

  const FechaHoraSelector({Key? key, required this.onFechaHoraSeleccionada})
      : super(key: key);

  @override
  _FechaHoraSelectorState createState() => _FechaHoraSelectorState();
}

class _FechaHoraSelectorState extends State<FechaHoraSelector> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
      _updateFechaHora();
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
      _updateFechaHora();
    }
  }

  void _updateFechaHora() {
    if (selectedDate != null && selectedTime != null) {
      DateTime finalDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      widget.onFechaHoraSeleccionada(finalDateTime);
    }
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
          SizedBox(height: 10), 

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

          SizedBox(height: 15), 

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
                    selectedTime != null
                        ? selectedTime!.format(context)
                        : "Seleccionar hora",
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