// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_select.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemData _$ItemDataFromJson(Map<String, dynamic> json) => ItemData(
      id: json['id'] as int,
      category: json['category'] as int,
      creatorId: json['creatorId'] as int,
      createQuantity: json['createQuantity'] as int,
      createTime: json['createTime'] as int,
      floatPosition: json['floatPosition'] as int,
      forbidden: json['forbidden'] as bool,
      name: json['name'] as String,
      collectable: json['collectable'] as bool,
      expiration: json['expiration'] as int,
      subcategory: json['subcategory'] as int,
      updateTimestamp: json['updateTimestamp'] as int,
      openAppButtonNameCode: json['openAppButtonNameCode'] as int,
      searchable: json['searchable'] as int,
    );

Map<String, dynamic> _$ItemDataToJson(ItemData instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'creatorId': instance.creatorId,
      'createQuantity': instance.createQuantity,
      'createTime': instance.createTime,
      'floatPosition': instance.floatPosition,
      'forbidden': instance.forbidden,
      'name': instance.name,
      'collectable': instance.collectable,
      'expiration': instance.expiration,
      'subcategory': instance.subcategory,
      'updateTimestamp': instance.updateTimestamp,
      'openAppButtonNameCode': instance.openAppButtonNameCode,
      'searchable': instance.searchable,
    };
