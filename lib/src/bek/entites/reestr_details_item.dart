import 'package:json_annotation/json_annotation.dart';
part 'reestr_details_item.g.dart';

@JsonSerializable()
class ReestrDetailsItem {
  final int reestrId;
  final String workStart;
  final String updatedAt;
  final String workEnd;
  final String createdAt;
  final int id;

  ReestrDetailsItem({
    this.reestrId = 0,
    this.workStart = '',
    this.updatedAt = '',
    this.workEnd = '',
    this.createdAt = '',
    this.id = 0,
  });

  factory ReestrDetailsItem.fromJson(Map<String, dynamic> json) => _$ReestrDetailsItemFromJson(json);
  Map<String, dynamic> toJson() => _$ReestrDetailsItemToJson(this);
}

