import 'package:json_annotation/json_annotation.dart';

import 'data_item.dart';
import 'data_reestr.dart';
part 'qery.g.dart';


@JsonSerializable()
class Qery {
  final int perPage;
  final List<DataItem>? data;
  final int lastPage;
  final String? nextPageUrl;
  final String? prevPageUrl;
  final String firstPageUrl;
  final String path;
  final int total;
  final String lastPageUrl;
  final int from;
  final List<Links>? links;
  final int to;
  final int currentPage;

  Qery({
    this.perPage = 0,
    this.data,
    this.lastPage = 0,
    this.nextPageUrl,
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

  factory Qery.fromJson(Map<String, dynamic> json) => _$QeryFromJson(json);
  Map<String, dynamic> toJson() => _$QeryToJson(this);
}