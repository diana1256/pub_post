// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataItem _$DataItemFromJson(Map<String, dynamic> json) => DataItem(
      workDate: json['workDate'] as String? ?? '',
      workDateEnd: json['workDateEnd'] as String? ?? '',
      userTimePenalty: json['userTimePenalty'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      userTimeEnd: json['userTimeEnd'] as String? ?? '',
      userTimeStart: json['userTimeStart'] as String? ?? '',
      reestrDetails: (json['reestrDetails'] as List<dynamic>)
          .map((e) => Reestretail.fromJson(e as Map<String, dynamic>))
          .toList(),
      late: json['late'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      userId: (json['userId'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num?)?.toInt() ?? 0,
      workDateStart: json['workDateStart'] as String? ?? '',
      user: UserItem.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataItemToJson(DataItem instance) => <String, dynamic>{
      'workDate': instance.workDate,
      'workDateEnd': instance.workDateEnd,
      'userTimePenalty': instance.userTimePenalty,
      'createdAt': instance.createdAt,
      'userTimeEnd': instance.userTimeEnd,
      'userTimeStart': instance.userTimeStart,
      'reestrDetails': instance.reestrDetails,
      'late': instance.late,
      'updatedAt': instance.updatedAt,
      'userId': instance.userId,
      'id': instance.id,
      'workDateStart': instance.workDateStart,
      'user': instance.user,
    };
