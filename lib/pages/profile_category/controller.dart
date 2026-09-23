part of 'index.dart';

class ProfileCategoryController extends GetxController {
  List<CategoryModel> selected = [];

  List<CategoryModel> get categories => ConfigStore.to.categories;

  void changedCategories(List<CategoryModel> value) => selected = value;
}
