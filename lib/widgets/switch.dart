part of 'index.dart';

class CustomSwitch extends CupertinoSwitch {
  const CustomSwitch({
    super.key,
    required super.value,
    required super.onChanged,
    Color? activeColor,
    Color? trackColor,
  }) : super(
          activeColor: activeColor ?? AppTheme.primary,
          trackColor: trackColor ?? const Color(0xFF9098A1),
        );
}
