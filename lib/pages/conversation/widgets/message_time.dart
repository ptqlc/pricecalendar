part of '../index.dart';

class BuildMessageTime extends StatelessWidget {
  final int timestamp;

  const BuildMessageTime({
    super.key,
    required this.timestamp,
  });

  bool get _isToday {
    final date = Date.fromMilli(timestamp);
    if (date == null) return false;
    final days = DateTime.now().toUtc().difference(date.toUtc()).inDays;
    return days <= 1;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      minimum: EdgeInsets.symmetric(
        horizontal: AppTheme.margin,
        vertical: 16.w,
      ),
      child: Text(
        Date.fromMilliToStr(timestamp, _isToday ? 'HH:mm' : 'yyyy/MM/dd HH:mm'),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14.w,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        ),
      ),
    );
  }
}
