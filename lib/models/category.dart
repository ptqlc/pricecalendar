part of 'index.dart';

class CategoryModel {
  CategoryModel({
    this.name,
    this.value,
    this.icon,
  });

  String? name;
  int? value;
  IconData? icon;

  CategoryModel copyWith({
    String? name,
    int? value,
    IconData? icon,
  }) =>
      CategoryModel(
        name: name ?? this.name,
        value: value ?? this.value,
        icon: icon ?? this.icon,
      );
}
