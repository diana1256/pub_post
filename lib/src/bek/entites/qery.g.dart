// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Qery _$QeryFromJson(Map<String, dynamic> json) => Qery(
      perPage: (json['perPage'] as num?)?.toInt() ?? 0,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastPage: (json['lastPage'] as num?)?.toInt() ?? 0,
      nextPageUrl: json['nextPageUrl'] as String?,
      prevPageUrl: json['prevPageUrl'] as String?,
      firstPageUrl: json['firstPageUrl'] as String? ?? '',
      path: json['path'] as String? ?? '',
      total: (json['total'] as num?)?.toInt() ?? 0,
      lastPageUrl: json['lastPageUrl'] as String? ?? '',
      from: (json['from'] as num?)?.toInt() ?? 0,
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => Links.fromJson(e as Map<String, dynamic>))
          .toList(),
      to: (json['to'] as num?)?.toInt() ?? 0,
      currentPage: (json['currentPage'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$QeryToJson(Qery instance) => <String, dynamic>{
      'perPage': instance.perPage,
      'data': instance.data,
      'lastPage': instance.lastPage,
      'nextPageUrl': instance.nextPageUrl,
      'prevPageUrl': instance.prevPageUrl,
      'firstPageUrl': instance.firstPageUrl,
      'path': instance.path,
      'total': instance.total,
      'lastPageUrl': instance.lastPageUrl,
      'from': instance.from,
      'links': instance.links,
      'to': instance.to,
      'currentPage': instance.currentPage,
    };
