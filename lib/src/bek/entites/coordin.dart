import 'package:json_annotation/json_annotation.dart';
part 'coordin.g.dart'; // Убедитесь, что имя файла совпадает


@JsonSerializable()
class Coordin {
  final String latitude;
  final String longitude;

  Coordin({this.latitude = '', this.longitude = ''});

  factory Coordin.fromJson(Map<String, dynamic> json) => _$CoordinFromJson(json);
  Map<String, dynamic> toJson() => _$CoordinToJson(this);
}

