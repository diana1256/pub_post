import 'package:json_annotation/json_annotation.dart';

import 'data_reestr.dart';
part 'data_item.g.dart';

@JsonSerializable()
class DataItem {
  final String workDate;
  final String workDateEnd;
  final String userTimePenalty;
  final String createdAt;
  final String userTimeEnd;
  final String userTimeStart;
  final List<Reestretail> reestrDetails;
  final String late;
  final String updatedAt;
  final int userId;
  final int id;
  final String workDateStart;
  final UserItem user;

  DataItem({
    this.workDate = '',
    this.workDateEnd = '',
    this.userTimePenalty = '',
    this.createdAt = '',
    this.userTimeEnd = '',
    this.userTimeStart = '',
    required this.reestrDetails,
    this.late = '',
    this.updatedAt = '',
    this.userId = 0,
    this.id = 0,
    this.workDateStart = '',
    required this.user,
  });

  // Factory method to create DataItem from DataReestr
  static DataItem fromDataReestr(DataItem dataReestr) {
    return DataItem(
      workDate: dataReestr.workDate, // Assuming these fields exist
      workDateEnd: dataReestr.workDateEnd, // Adjust these fields according to your DataReestr
      userTimePenalty: dataReestr.userTimePenalty, // Adjust as needed
      createdAt: dataReestr.createdAt, // Adjust as needed
      userTimeEnd: dataReestr.userTimeEnd, // Adjust as needed
      userTimeStart: dataReestr.userTimeStart, // Adjust as needed
      reestrDetails: dataReestr.reestrDetails, // Ensure this is a valid type
      late: dataReestr.late, // Adjust as needed
      updatedAt: dataReestr.updatedAt, // Adjust as needed
      userId: dataReestr.userId, // Adjust as needed
      id: dataReestr.id, // Adjust as needed
      workDateStart: dataReestr.workDateStart, // Adjust as needed
      user: dataReestr.user, // Ensure this is a valid type
    );
  }

  factory DataItem.fromJson(Map<String, dynamic> json) => _$DataItemFromJson(json);
  Map<String, dynamic> toJson() => _$DataItemToJson(this);
}
