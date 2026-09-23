part of 'index.dart';

class GeekModel {
  GeekModel({
    this.name,
    this.email,
    this.birthday,
    this.occupation,
    this.address,
    this.avatar,
  });

  GeekModel.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    birthday = json['birthday'];
    occupation = json['occupation'];
    address = json['address'];
    avatar = json['avatar'];
  }

  String? name;
  String? email;
  int? birthday;
  String? occupation;
  String? address;
  String? avatar;

  GeekModel copyWith({
    String? name,
    String? email,
    int? birthday,
    String? occupation,
    String? address,
    String? avatar,
  }) =>
      GeekModel(
        name: name ?? this.name,
        email: email ?? this.email,
        birthday: birthday ?? this.birthday,
        occupation: occupation ?? this.occupation,
        address: address ?? this.address,
        avatar: avatar ?? this.avatar,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['birthday'] = birthday;
    map['occupation'] = occupation;
    map['address'] = address;
    map['avatar'] = avatar;
    return map;
  }
}
