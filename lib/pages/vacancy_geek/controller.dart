part of 'index.dart';

class VacancyGeekController extends GetxController {
  final TextEditingController markInput = TextEditingController();
  final TextEditingController dateInput = TextEditingController();
  final TextEditingController messageInput = TextEditingController();

  String? mark;

  @override
  void onClose() {
    markInput.dispose();
    dateInput.dispose();
    messageInput.dispose();
    super.onClose();
  }

  void changeMark(String value) {
    markInput.text = value;
    mark = value;
  }

  void changeDate(DateTime value) => dateInput.text = Date.fromTime(value);
}
