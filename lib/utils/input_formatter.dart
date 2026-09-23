part of 'index.dart';

class AmountInputFormatter extends TextInputFormatter {
  final RegExp _exp = RegExp(r'(^[1-9](\d+)?(\.)?(\d{1,2})?$)|(^(0)$)|(^(\d+)?(\.)?(\d{1,2})?$)');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty || _exp.hasMatch(newValue.text)) return newValue;
    return oldValue;
  }
}
