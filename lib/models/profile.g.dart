// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile()
    ..login = json['user'] as String
    ..login = json['login'] as String
    ..avatarRrl = json['avatarRrl'] as String
    ..token = json['token'] as String
    ..theme = json['theme'] as num
    ..lastLogin = json['lastLogin'] as String
    ..locale = json['locale'] as String;
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'user': instance.user,
      'login': instance.login,
      'avatarRrl': instance.avatarRrl,
      'token': instance.token,
      'theme': instance.theme,
      'lastLogin': instance.lastLogin,
      'locale': instance.locale
    };
