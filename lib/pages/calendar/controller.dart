part of 'index.dart';

class CalendarController extends GetxController {
  static const initialPage = 1200;

  late final PageController monthController;
  int page = initialPage;
  DateTime selectedDate = DateTime.now();
  int selectionAnimationKey = 0;

  @override
  void onInit() {
    super.onInit();
    monthController = PageController(initialPage: initialPage);
  }

  DateTime monthForPage(int value) {
    final now = DateTime.now();
    return DateTime(now.year, now.month + value - initialPage);
  }

  @override
  void onClose() {
    monthController.dispose();
    super.onClose();
  }
}
