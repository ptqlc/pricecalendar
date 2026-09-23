part of 'index.dart';

class CountryModel {
  CountryModel({
    this.name,
    this.prefix,
  });

  CountryModel.fromJson(dynamic json) {
    name = json['name'];
    prefix = json['prefix'];
  }

  String? name;
  String? prefix;

  CountryModel copyWith({
    String? name,
    String? prefix,
  }) =>
      CountryModel(
        name: name ?? this.name,
        prefix: prefix ?? this.prefix,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['prefix'] = prefix;
    return map;
  }
}
