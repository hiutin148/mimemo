// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_minute_cast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneMinuteCast _$OneMinuteCastFromJson(Map<String, dynamic> json) =>
    OneMinuteCast(
      summary: json['Summary'] == null
          ? null
          : MinuteCastSummary.fromJson(json['Summary'] as Map<String, dynamic>),
      summaries: (json['Summaries'] as List<dynamic>?)
          ?.map(
            (e) => MinuteCastRangeSummary.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      intervals: (json['Intervals'] as List<dynamic>?)
          ?.map((e) => MinuteInterval.fromJson(e as Map<String, dynamic>))
          .toList(),
      mobileLink: json['MobileLink'] as String?,
      link: json['Link'] as String?,
    );

Map<String, dynamic> _$OneMinuteCastToJson(OneMinuteCast instance) =>
    <String, dynamic>{
      'Summary': instance.summary?.toJson(),
      'Summaries': instance.summaries?.map((e) => e.toJson()).toList(),
      'Intervals': instance.intervals?.map((e) => e.toJson()).toList(),
      'MobileLink': instance.mobileLink,
      'Link': instance.link,
    };

MinuteCastSummary _$MinuteCastSummaryFromJson(Map<String, dynamic> json) =>
    MinuteCastSummary(
      phrase: json['Phrase'] as String?,
      phrase60: json['Phrase_60'] as String?,
      widgetPhrase: json['WidgetPhrase'] as String?,
      shortPhrase: json['ShortPhrase'] as String?,
      briefPhrase: json['BriefPhrase'] as String?,
      longPhrase: json['LongPhrase'] as String?,
      iconCode: (json['IconCode'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MinuteCastSummaryToJson(MinuteCastSummary instance) =>
    <String, dynamic>{
      'Phrase': instance.phrase,
      'Phrase_60': instance.phrase60,
      'WidgetPhrase': instance.widgetPhrase,
      'ShortPhrase': instance.shortPhrase,
      'BriefPhrase': instance.briefPhrase,
      'LongPhrase': instance.longPhrase,
      'IconCode': instance.iconCode,
    };

MinuteCastRangeSummary _$MinuteCastRangeSummaryFromJson(
  Map<String, dynamic> json,
) => MinuteCastRangeSummary(
  startMinute: (json['StartMinute'] as num?)?.toInt(),
  endMinute: (json['EndMinute'] as num?)?.toInt(),
  countMinute: (json['CountMinute'] as num?)?.toInt(),
  minuteText: json['MinuteText'] as String?,
  minutesText: json['MinutesText'] as String?,
  widgetPhrase: json['WidgetPhrase'] as String?,
  shortPhrase: json['ShortPhrase'] as String?,
  briefPhrase: json['BriefPhrase'] as String?,
  longPhrase: json['LongPhrase'] as String?,
  iconCode: (json['IconCode'] as num?)?.toInt(),
);

Map<String, dynamic> _$MinuteCastRangeSummaryToJson(
  MinuteCastRangeSummary instance,
) => <String, dynamic>{
  'StartMinute': instance.startMinute,
  'EndMinute': instance.endMinute,
  'CountMinute': instance.countMinute,
  'MinuteText': instance.minuteText,
  'MinutesText': instance.minutesText,
  'WidgetPhrase': instance.widgetPhrase,
  'ShortPhrase': instance.shortPhrase,
  'BriefPhrase': instance.briefPhrase,
  'LongPhrase': instance.longPhrase,
  'IconCode': instance.iconCode,
};

MinuteInterval _$MinuteIntervalFromJson(Map<String, dynamic> json) =>
    MinuteInterval(
      startDateTime: json['StartDateTime'] as String?,
      startEpochDateTime: (json['StartEpochDateTime'] as num?)?.toInt(),
      minute: (json['Minute'] as num?)?.toInt(),
      dbz: (json['Dbz'] as num?)?.toDouble(),
      shortPhrase: json['ShortPhrase'] as String?,
      iconCode: (json['IconCode'] as num?)?.toInt(),
      cloudCover: (json['CloudCover'] as num?)?.toInt(),
      lightningRate: (json['LightningRate'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MinuteIntervalToJson(MinuteInterval instance) =>
    <String, dynamic>{
      'StartDateTime': instance.startDateTime,
      'StartEpochDateTime': instance.startEpochDateTime,
      'Minute': instance.minute,
      'Dbz': instance.dbz,
      'ShortPhrase': instance.shortPhrase,
      'IconCode': instance.iconCode,
      'CloudCover': instance.cloudCover,
      'LightningRate': instance.lightningRate,
    };
