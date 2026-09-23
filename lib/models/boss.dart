part of 'index.dart';

class BossModel {
  BossModel({
    this.name,
    this.email,
    this.established,
    this.country,
    this.address,
    this.logo,
  });

  BossModel.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    established = json['established'];
    country = json['country'];
    address = json['address'];
    logo = json['logo'];
  }

  String? name;
  String? email;
  int? established;
  String? country;
  String? address;
  String? logo;

  BossModel copyWith({
    String? name,
    String? email,
    int? established,
    String? country,
    String? address,
    String? logo,
  }) =>
      BossModel(
        name: name ?? this.name,
        email: email ?? this.email,
        established: established ?? this.established,
        country: country ?? this.country,
        address: address ?? this.address,
        logo: logo ?? this.logo,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['established'] = established;
    map['country'] = country;
    map['address'] = address;
    map['logo'] = logo;
    return map;
  }
}
