// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_reestr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataReestr _$DataReestrFromJson(Map<String, dynamic> json) => DataReestr(
      perPage: (json['perPage'] as num?)?.toInt() ?? 0,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastPage: (json['lastPage'] as num?)?.toInt() ?? 0,
      nextPageUrl: json['nextPageUrl'] as String? ?? '',
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

Map<String, dynamic> _$DataReestrToJson(DataReestr instance) =>
    <String, dynamic>{
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

UserItem _$UserItemFromJson(Map<String, dynamic> json) => UserItem(
      birthday: json['birthday'] as String? ?? '',
      fired: json['fired'] as String?,
      gender: json['gender'] as bool? ?? false,
      affiliateId: (json['affiliateId'] as num?)?.toInt() ?? 0,
      departmentId: (json['departmentId'] as num?)?.toInt() ?? 0,
      workTimeEnd: json['workTimeEnd'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      active: json['active'] as bool? ?? false,
      remote: json['remote'] as bool? ?? false,
      createdAt: json['createdAt'] as String? ?? '',
      emailVerifiedAt: json['emailVerifiedAt'] as String?,
      workTimeStart: json['workTimeStart'] as String? ?? '',
      middleName: json['middleName'] as String? ?? '',
      penaltyTime: json['penaltyTime'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      roleId: (json['roleId'] as num?)?.toInt() ?? 0,
      hired: json['hired'] as String? ?? '',
      id: (json['id'] as num?)?.toInt() ?? 0,
      authorId: (json['authorId'] as num?)?.toInt() ?? 0,
      firstName: json['firstName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      status: json['status'] as bool? ?? false,
      positionId: (json['positionId'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$UserItemToJson(UserItem instance) => <String, dynamic>{
      'birthday': instance.birthday,
      'fired': instance.fired,
      'gender': instance.gender,
      'affiliateId': instance.affiliateId,
      'departmentId': instance.departmentId,
      'workTimeEnd': instance.workTimeEnd,
      'lastName': instance.lastName,
      'active': instance.active,
      'remote': instance.remote,
      'createdAt': instance.createdAt,
      'emailVerifiedAt': instance.emailVerifiedAt,
      'workTimeStart': instance.workTimeStart,
      'middleName': instance.middleName,
      'penaltyTime': instance.penaltyTime,
      'updatedAt': instance.updatedAt,
      'phone': instance.phone,
      'roleId': instance.roleId,
      'hired': instance.hired,
      'id': instance.id,
      'authorId': instance.authorId,
      'firstName': instance.firstName,
      'email': instance.email,
      'status': instance.status,
      'positionId': instance.positionId,
    };

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      active: json['active'] as bool? ?? false,
      label: json['label'] as String? ?? '',
      url: json['url'] as String?,
    );

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'active': instance.active,
      'label': instance.label,
      'url': instance.url,
    };

Reestretail _$ReestretailFromJson(Map<String, dynamic> json) => Reestretail(
      reestrId: (json['reestrId'] as num?)?.toInt() ?? 0,
      workStart: json['workStart'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      workEnd: json['workEnd'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      id: (json['id'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ReestretailToJson(Reestretail instance) =>
    <String, dynamic>{
      'reestrId': instance.reestrId,
      'workStart': instance.workStart,
      'updatedAt': instance.updatedAt,
      'workEnd': instance.workEnd,
      'createdAt': instance.createdAt,
      'id': instance.id,
    };
