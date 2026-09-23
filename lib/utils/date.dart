part of 'index.dart';

abstract class Date {
  static String fromTime(DateTime? date, [String? pattern]) {
    if (date == null) return '';
    return DateFormat(
      pattern ?? 'y/MM/dd',
      ConfigStore.to.locale.toString(),
    ).format(date.toLocal());
  }

  static DateTime? fromStr(String? date, [String? pattern]) {
    if ((date ?? '').isEmpty) return null;
    return DateFormat(
      pattern ?? 'y/MM/dd',
      ConfigStore.to.locale.toString(),
    ).parse(date!).toLocal();
  }

  static DateTime? fromMilli(int? date, [String? pattern]) {
    if (date == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(date).toUtc();
  }

  static int fromStrToMilli(String? date, [String? pattern]) {
    return fromStr(date, pattern)?.toUtc().millisecondsSinceEpoch ?? 0;
  }

  static int fromTimeToMilli(DateTime? date, [String? pattern]) {
    return fromStrToMilli(fromTime(date, pattern), pattern);
  }

  static String fromMilliToStr(int? date, [String? pattern]) {
    if (date == null) return '';
    return fromTime(DateTime.fromMillisecondsSinceEpoch(date), pattern);
  }
}
