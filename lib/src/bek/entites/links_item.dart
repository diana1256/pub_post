import 'package:json_annotation/json_annotation.dart';

part 'links_item.g.dart';

@JsonSerializable()
class LinksItem {
  final bool active;
  final String label;
  final String? url;

  LinksItem({
    this.active = false,
    this.label = '',
    this.url,
  });

  factory LinksItem.fromJson(Map<String, dynamic> json) => _$LinksItemFromJson(json);
  Map<String, dynamic> toJson() => _$LinksItemToJson(this);
}
