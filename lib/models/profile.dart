part of 'index.dart';

class ProfileModel {
  ProfileModel({
    this.geek,
    this.boss,
  });

  GeekModel? geek;
  BossModel? boss;

  ProfileModel copyWith({
    GeekModel? geek,
    BossModel? boss,
  }) =>
      ProfileModel(
        geek: geek ?? this.geek,
        boss: boss ?? this.boss,
      );
}
