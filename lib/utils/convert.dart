part of 'index.dart';

abstract class Convert {
  static String toAmount(String? value) {
    final format = NumberFormat('#,##0.00');
    return '\$${format.format(double.tryParse(value.toString()) ?? 0)}';
  }
}
