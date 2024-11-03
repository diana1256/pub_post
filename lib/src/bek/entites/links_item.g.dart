// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'links_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinksItem _$LinksItemFromJson(Map<String, dynamic> json) => LinksItem(
      active: json['active'] as bool? ?? false,
      label: json['label'] as String? ?? '',
      url: json['url'] as String?,
    );

Map<String, dynamic> _$LinksItemToJson(LinksItem instance) => <String, dynamic>{
      'active': instance.active,
      'label': instance.label,
      'url': instance.url,
    };
