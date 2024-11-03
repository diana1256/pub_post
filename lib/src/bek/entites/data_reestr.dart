import 'package:json_annotation/json_annotation.dart';

import 'data_item.dart';
part 'data_reestr.g.dart';

@JsonSerializable()
class DataReestr {
  final int perPage;
  final List<DataItem>? data;
  final int lastPage;
  final String nextPageUrl;
  final String? prevPageUrl;
  final String firstPageUrl;
  final String path;
  final int total;
  final String lastPageUrl;
  final int from;
  final List<Links>? links;
  final int to;
  final int currentPage;

  DataReestr({
    this.perPage = 0,
    this.data,
    this.lastPage = 0,
    this.nextPageUrl = '',
    this.prevPageUrl,
    this.firstPageUrl = '',
    this.path = '',
    this.total = 0,
    this.lastPageUrl = '',
    this.from = 0,
    this.links,
    this.to = 0,
    this.currentPage = 0,
  });

  factory DataReestr.fromJson(Map<String, dynamic> json) => _$DataReestrFromJson(json);
  Map<String, dynamic> toJson() => _$DataReestrToJson(this);
}

@JsonSerializable()
class UserItem {
  final String birthday;
  final String? fired;
  final bool gender;
  final int affiliateId;
  final int departmentId;
  final String workTimeEnd;
  final String lastName;
  final bool active;
  final bool remote;
  final String createdAt;
  final String? emailVerifiedAt;
  final String workTimeStart;
  final String middleName;
  final String penaltyTime;
  final String updatedAt;
  final String phone;
  final int roleId;
  final String hired;
  final int id;
  final int authorId;
  final String firstName;
  final String email;
  final bool status;
  final int positionId;

  UserItem({
    this.birthday = '',
    this.fired,
    this.gender = false,
    this.affiliateId = 0,
    this.departmentId = 0,
    this.workTimeEnd = '',
    this.lastName = '',
    this.active = false,
    this.remote = false,
    this.createdAt = '',
    this.emailVerifiedAt,
    this.workTimeStart = '',
    this.middleName = '',
    this.penaltyTime = '',
    this.updatedAt = '',
    this.phone = '',
    this.roleId = 0,
    this.hired = '',
    this.id = 0,
    this.authorId = 0,
    this.firstName = '',
    this.email = '',
    this.status = false,
    this.positionId = 0,
  });

  factory UserItem.fromJson(Map<String, dynamic> json) => _$UserItemFromJson(json);
  Map<String, dynamic> toJson() => _$UserItemToJson(this);
}

@JsonSerializable()
class Links {
  final bool active;
  final String label;
  final String? url;

  Links({this.active = false, this.label = '', this.url});

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

@JsonSerializable()
class Reestretail {
  final int reestrId;
  final String workStart;
  final String updatedAt;
  final String workEnd;
  final String createdAt;
  final int id;

  Reestretail({
    this.reestrId = 0,
    this.workStart = '',
    this.updatedAt = '',
    this.workEnd = '',
    this.createdAt = '',
    this.id = 0,
  });

  factory Reestretail.fromJson(Map<String, dynamic> json) => _$ReestretailFromJson(json);
  Map<String, dynamic> toJson() => _$ReestretailToJson(this);
}
