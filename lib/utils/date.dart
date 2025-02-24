import 'package:intl/intl.dart';

class AppDate{
  static String formateoFechaDetalle( DateTime date) {
    String formattedDateTime = DateFormat('EEEE d MMMM y - HH:mm', 'es_ES').format(date);
    return '${formattedDateTime[0].toUpperCase()}${formattedDateTime.substring(1)}';
  }

  // 7/10/1996 5:08 PM
  static String formateoFechaSimple( DateTime date) {
    String formattedDateTime = DateFormat('dd/MM/y - HH:mm', 'es_ES').format(date);
    return '${formattedDateTime[0].toUpperCase()}${formattedDateTime.substring(1)}';
  }
}
