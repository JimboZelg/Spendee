import 'package:intl/intl.dart'; // Para formatear fechas y números

class Formatters {
  // Formatear una fecha a un formato legible (ejemplo: "12 de octubre de 2023")
  static String formatDate(DateTime date) {
    final formatter = DateFormat('d MMMM y', 'es');
    return formatter.format(date);
  }

  // Formatear un número como moneda (ejemplo: "\$1,000.00")
  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      symbol: '\$', // Símbolo de la moneda
      decimalDigits: 2, // Número de decimales
    );
    return formatter.format(amount);
  }

  // Formatear un número como porcentaje (ejemplo: "50%")
  static String formatPercentage(double value) {
    final formatter = NumberFormat.percentPattern();
    return formatter.format(value);
  }
}