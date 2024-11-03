import 'package:json_annotation/json_annotation.dart';

part 'Reestr.g.dart'; // Измените на 'reestr.g.dart', если файл называется так

@JsonSerializable()
class Auth {
  final String lastName;
  final int id;
  final String position;
  final String department;
  final bool remote;
  final String firstName;
  final String token;

  Auth({
    this.lastName = '',
    this.id = 0,
    this.position = '',
    this.department = '',
    this.remote = false,
    this.firstName = '',
    this.token = '',
  });

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
  Map<String, dynamic> toJson() => _$AuthToJson(this);
}

@JsonSerializable()
class ResultData {
  final String lastName;
  final int id;
  final String position;
  final String department;
  final bool remote;
  final String firstName;
  final String avatar;

  ResultData({
    this.lastName = '',
    this.id = 0,
    this.position = '',
    this.department = '',
    this.remote = false,
    this.firstName = '',
    this.avatar = '',
  });

  factory ResultData.fromJson(Map<String, dynamic> json) => _$ResultDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResultDataToJson(this);
}
