// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_select.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemSelectResponse _$ItemSelectResponseFromJson(Map<String, dynamic> json) =>
    ItemSelectResponse(
      errorCode: json['errorCode'] as String,
      itemList: json['itemList'] as List<dynamic>,
    );

Map<String, dynamic> _$ItemSelectResponseToJson(ItemSelectResponse instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'itemList': instance.itemList,
    };
