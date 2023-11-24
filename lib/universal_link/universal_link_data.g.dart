// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'universal_link_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UniversalLinkParamData _$UniversalLinkParamDataFromJson(
        Map<String, dynamic> json) =>
    UniversalLinkParamData(
      json['phoneNumber'] as String?,
      json['userID'] as String?,
      json['commodityID'] as String?,
      json['lang'] as String?,
      json['metadataID'] as String?,
    );

Map<String, dynamic> _$UniversalLinkParamDataToJson(
        UniversalLinkParamData instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'phoneNumber': instance.phoneNumber,
      'commodityID': instance.commodityID,
      'lang': instance.lang,
      'vendorID': instance.vendorID,
      'vendorToken': instance.vendorToken,
      'serial': instance.serial,
      'openExternalBrowser': instance.openExternalBrowser,
      'metadataID': instance.metadataID,
    };
