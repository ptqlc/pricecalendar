part of 'index.dart';

abstract class Validator<T> {
  final String error;

  Validator(this.error);

  bool isValid(T value);

  String? call(T value) => isValid(value) ? null : error;

  bool hasMatch(
    String pattern,
    String value, {
    bool caseSensitive = true,
  }) =>
      RegExp(
        pattern,
        caseSensitive: caseSensitive,
      ).hasMatch(value);
}

class RequiredValidator extends Validator<String?> {
  RequiredValidator() : super('This field is required');

  @override
  bool isValid(String? value) => (value ?? '').isNotEmpty;
}

class EmailValidator extends Validator<String?> {
  final Pattern _pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  EmailValidator() : super('Email is invalid');

  @override
  bool isValid(String? value) {
    if ((value ?? '').isEmpty) return true;
    return hasMatch(_pattern.toString(), value!, caseSensitive: false);
  }
}

class PasswordValidator extends Validator<String?> {
  final Pattern _pattern = r'(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$';

  PasswordValidator()
      : super('The password oil consists of 6 to 16 digits and letters');

  @override
  bool isValid(String? value) {
    if ((value ?? '').isEmpty) return true;
    return hasMatch(_pattern.toString(), value!, caseSensitive: false);
  }
}

class EqualValidator extends Validator<String?> {
  final TextEditingController input;

  EqualValidator(this.input) : super('Does not match the password');

  @override
  bool isValid(String? value) {
    if ((value ?? '').isEmpty) return true;
    return input.value.text == value;
  }
}

class AmountValidator extends Validator<String?> {
  final Pattern _pattern =
      r'(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)';

  AmountValidator() : super('Amount is invalid');

  @override
  bool isValid(String? value) {
    if ((value ?? '').isEmpty) return true;
    return hasMatch(_pattern.toString(), value!, caseSensitive: false);
  }
}
