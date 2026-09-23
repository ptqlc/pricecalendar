part of 'index.dart';

class VacancyEditController extends GetxController {
  final TextEditingController positionInput = TextEditingController();
  final TextEditingController salaryInput = TextEditingController();
  final TextEditingController locationInput = TextEditingController();
  final TextEditingController typeInput = TextEditingController();
  final TextEditingController statusInput = TextEditingController();

  List<String> requirementList = [];
  String? type;
  String? status;

  @override
  void onClose() {
    positionInput.dispose();
    salaryInput.dispose();
    locationInput.dispose();
    typeInput.dispose();
    statusInput.dispose();
    super.onClose();
  }

  void changeRequirementList(List<String> value) => requirementList = value;

  void changeLocation(String value) => locationInput.text = value;

  void changeType(String value) {
    typeInput.text = value;
    type = value;
  }

  void changeStatus(String value) {
    statusInput.text = value;
    status = value;
  }
}
