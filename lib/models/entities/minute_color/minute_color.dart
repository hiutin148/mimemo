import 'package:json_annotation/json_annotation.dart';

part 'minute_color.g.dart';

@JsonSerializable()
class MinuteColor {
  @JsonKey(name: 'Type')
  final String? type;

  @JsonKey(name: 'Threshold')
  final String? threshold;

  @JsonKey(name: 'StartDbz')
  final double? startDbz;

  @JsonKey(name: 'EndDbz')
  final double? endDbz;

  @JsonKey(name: 'Red')
  final int? red;

  @JsonKey(name: 'Green')
  final int? green;

  @JsonKey(name: 'Blue')
  final int? blue;

  @JsonKey(name: 'Hex')
  final String? hex;

  MinuteColor({
    this.type,
    this.threshold,
    this.startDbz,
    this.endDbz,
    this.red,
    this.green,
    this.blue,
    this.hex,
  });

  factory MinuteColor.fromJson(Map<String, dynamic> json) =>
      _$MinuteColorFromJson(json);

  Map<String, dynamic> toJson() => _$MinuteColorToJson(this);
}
