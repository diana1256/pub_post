// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reestr_details_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReestrDetailsItem _$ReestrDetailsItemFromJson(Map<String, dynamic> json) =>
    ReestrDetailsItem(
      reestrId: (json['reestrId'] as num?)?.toInt() ?? 0,
      workStart: json['workStart'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      workEnd: json['workEnd'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      id: (json['id'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ReestrDetailsItemToJson(ReestrDetailsItem instance) =>
    <String, dynamic>{
      'reestrId': instance.reestrId,
      'workStart': instance.workStart,
      'updatedAt': instance.updatedAt,
      'workEnd': instance.workEnd,
      'createdAt': instance.createdAt,
      'id': instance.id,
    };
