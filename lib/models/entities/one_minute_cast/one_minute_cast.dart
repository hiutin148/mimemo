import 'package:json_annotation/json_annotation.dart';

part 'one_minute_cast.g.dart';

@JsonSerializable(explicitToJson: true)
class OneMinuteCast {

  OneMinuteCast({
    this.summary,
    this.summaries,
    this.intervals,
    this.mobileLink,
    this.link,
  });

  factory OneMinuteCast.fromJson(Map<String, dynamic> json) =>
      _$OneMinuteCastFromJson(json);
  @JsonKey(name: 'Summary')
  final MinuteCastSummary? summary;

  @JsonKey(name: 'Summaries')
  final List<MinuteCastRangeSummary>? summaries;

  @JsonKey(name: 'Intervals')
  final List<MinuteInterval>? intervals;

  @JsonKey(name: 'MobileLink')
  final String? mobileLink;

  @JsonKey(name: 'Link')
  final String? link;
  Map<String, dynamic> toJson() => _$OneMinuteCastToJson(this);
}

@JsonSerializable()
class MinuteCastSummary {

  MinuteCastSummary({
    this.phrase,
    this.phrase60,
    this.widgetPhrase,
    this.shortPhrase,
    this.briefPhrase,
    this.longPhrase,
    this.iconCode,
  });

  factory MinuteCastSummary.fromJson(Map<String, dynamic> json) =>
      _$MinuteCastSummaryFromJson(json);
  @JsonKey(name: 'Phrase')
  final String? phrase;

  @JsonKey(name: 'Phrase_60')
  final String? phrase60;

  @JsonKey(name: 'WidgetPhrase')
  final String? widgetPhrase;

  @JsonKey(name: 'ShortPhrase')
  final String? shortPhrase;

  @JsonKey(name: 'BriefPhrase')
  final String? briefPhrase;

  @JsonKey(name: 'LongPhrase')
  final String? longPhrase;

  @JsonKey(name: 'IconCode')
  final int? iconCode;
  Map<String, dynamic> toJson() => _$MinuteCastSummaryToJson(this);
}

@JsonSerializable()
class MinuteCastRangeSummary {

  MinuteCastRangeSummary({
    this.startMinute,
    this.endMinute,
    this.countMinute,
    this.minuteText,
    this.minutesText,
    this.widgetPhrase,
    this.shortPhrase,
    this.briefPhrase,
    this.longPhrase,
    this.iconCode,
  });

  factory MinuteCastRangeSummary.fromJson(Map<String, dynamic> json) =>
      _$MinuteCastRangeSummaryFromJson(json);
  @JsonKey(name: 'StartMinute')
  final int? startMinute;

  @JsonKey(name: 'EndMinute')
  final int? endMinute;

  @JsonKey(name: 'CountMinute')
  final int? countMinute;

  @JsonKey(name: 'MinuteText')
  final String? minuteText;

  @JsonKey(name: 'MinutesText')
  final String? minutesText;

  @JsonKey(name: 'WidgetPhrase')
  final String? widgetPhrase;

  @JsonKey(name: 'ShortPhrase')
  final String? shortPhrase;

  @JsonKey(name: 'BriefPhrase')
  final String? briefPhrase;

  @JsonKey(name: 'LongPhrase')
  final String? longPhrase;

  @JsonKey(name: 'IconCode')
  final int? iconCode;
  Map<String, dynamic> toJson() => _$MinuteCastRangeSummaryToJson(this);
}

@JsonSerializable()
class MinuteInterval {

  MinuteInterval({
    this.startDateTime,
    this.startEpochDateTime,
    this.minute,
    this.dbz,
    this.shortPhrase,
    this.iconCode,
    this.cloudCover,
    this.lightningRate,
  });

  factory MinuteInterval.fromJson(Map<String, dynamic> json) =>
      _$MinuteIntervalFromJson(json);
  @JsonKey(name: 'StartDateTime')
  final String? startDateTime;

  @JsonKey(name: 'StartEpochDateTime')
  final int? startEpochDateTime;

  @JsonKey(name: 'Minute')
  final int? minute;

  @JsonKey(name: 'Dbz')
  final double? dbz;

  @JsonKey(name: 'ShortPhrase')
  final String? shortPhrase;

  @JsonKey(name: 'IconCode')
  final int? iconCode;

  @JsonKey(name: 'CloudCover')
  final int? cloudCover;

  @JsonKey(name: 'LightningRate')
  final int? lightningRate;
  Map<String, dynamic> toJson() => _$MinuteIntervalToJson(this);
}
