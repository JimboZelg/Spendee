import 'package:intl/intl.dart';

class Helpers {
  // Calcular el total de una lista de gastos
  static double calculateTotal(List<double> amounts) {
    return amounts.fold(0, (sum, amount) => sum + amount);
  }

  // Redondear un número a 2 decimales
  static double roundToTwoDecimals(double value) {
    return double.parse(value.toStringAsFixed(2));
  }

  // Obtener el mes actual como texto (ejemplo: "Octubre")
  static String getCurrentMonth() {
    final now = DateTime.now();
    final formatter = DateFormat('MMMM', 'es');
    return formatter.format(now);
  }

  // Verificar si una lista está vacía
  static bool isListEmpty(List<dynamic> list) {
    return list.isEmpty;
  }
}