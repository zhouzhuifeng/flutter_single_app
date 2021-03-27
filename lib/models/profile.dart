// import 'package:json_annotation/json_annotation.dart';
part 'profile.g.dart';
@JsonSerializable()
class Profile {
  Profile();
  String user;
  String login;
  String avatarRrl;
  String token;
  num theme;
  String lastLogin;
  String locale;
  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

class JsonSerializable {
  const JsonSerializable();
}
