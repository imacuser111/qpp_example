// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_language_item_description_select.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiLanguageItemDescriptionData _$MultiLanguageItemDescriptionDataFromJson(
        Map<String, dynamic> json) =>
    MultiLanguageItemDescriptionData(
      CHT: json['CHT'] as String?,
      CHS: json['CHS'] as String?,
      ID: json['ID'] as String?,
      IN: json['IN'] as String?,
      JP: json['JP'] as String?,
      KR: json['KR'] as String?,
      TH: json['TH'] as String?,
      US: json['US'] as String?,
      VN: json['VN'] as String?,
      defaultLanguage: json['defaultLanguage'] as int,
      isMulti: json['isMulti'] as bool,
      itemId: json['itemId'] as int,
      updateTime: json['updateTime'] as int,
    );

Map<String, dynamic> _$MultiLanguageItemDescriptionDataToJson(
        MultiLanguageItemDescriptionData instance) =>
    <String, dynamic>{
      'CHT': instance.CHT,
      'CHS': instance.CHS,
      'ID': instance.ID,
      'IN': instance.IN,
      'JP': instance.JP,
      'KR': instance.KR,
      'TH': instance.TH,
      'US': instance.US,
      'VN': instance.VN,
      'defaultLanguage': instance.defaultLanguage,
      'isMulti': instance.isMulti,
      'itemId': instance.itemId,
      'updateTime': instance.updateTime,
    };
