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
    )
      ..vendorID = json['vendorID'] as String?
      ..vendorToken = json['vendorToken'] as String?
      ..serial = json['serial'] as String?
      ..openExternalBrowser = json['openExternalBrowser'] as String?;

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
    };
