// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Reestr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) => Auth(
      lastName: json['lastName'] as String? ?? '',
      id: (json['id'] as num?)?.toInt() ?? 0,
      position: json['position'] as String? ?? '',
      department: json['department'] as String? ?? '',
      remote: json['remote'] as bool? ?? false,
      firstName: json['firstName'] as String? ?? '',
      token: json['token'] as String? ?? '',
    );

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'lastName': instance.lastName,
      'id': instance.id,
      'position': instance.position,
      'department': instance.department,
      'remote': instance.remote,
      'firstName': instance.firstName,
      'token': instance.token,
    };

ResultData _$ResultDataFromJson(Map<String, dynamic> json) => ResultData(
      lastName: json['lastName'] as String? ?? '',
      id: (json['id'] as num?)?.toInt() ?? 0,
      position: json['position'] as String? ?? '',
      department: json['department'] as String? ?? '',
      remote: json['remote'] as bool? ?? false,
      firstName: json['firstName'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
    );

Map<String, dynamic> _$ResultDataToJson(ResultData instance) =>
    <String, dynamic>{
      'lastName': instance.lastName,
      'id': instance.id,
      'position': instance.position,
      'department': instance.department,
      'remote': instance.remote,
      'firstName': instance.firstName,
      'avatar': instance.avatar,
    };
