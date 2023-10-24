import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'item_select.g.dart';

class ItemSelectRequest {
  String createItemSelectBody(List<String> itemIds) {
    return json.encode({'itemIds': itemIds});
  }
}

/// 搜尋物品資訊
class ItemSelectInfoResponse {
  final List<dynamic> itemList;

  const ItemSelectInfoResponse({required this.itemList});

  factory ItemSelectInfoResponse.fromJson(Map<String, dynamic> json) {
    return ItemSelectInfoResponse(itemList: json['itemList']);
  }

  ItemData getItem(int index) {
    try {
      return ItemData.fromJson(itemList[index]);
    } catch (exception) {
      print('error $exception');
      rethrow;
    }
  }

  List<ItemData> get allItems {
    List<ItemData> result = List.empty();
    for (var element in itemList) {
      result.add(ItemData.fromJson(element));
    }
    return result;
  }
}

@JsonSerializable()
class ItemData {
  // 物品ID
  final int id;
  // 物品類別
  final int category;
  // 創作者ID
  final int creatorId;
  // 取得創造數量 BigInt
  // return BigInt.from(data['createQuantity']);
  final int createQuantity;
  // 取得創造時間
  final int createTime;
  // 取得浮點位置
  final int floatPosition;
  // 是否禁止交易
  final bool forbidden;
  // 取得物品名稱
  final String name;
  // 是否允許 收取/代收
  final bool collectable;
  // 取得有效期限
  final int expiration;
  // 取得次要類別
  final int subcategory;
  // 取得更新時戳
  final int updateTimestamp;
  // 取得按鈕開啟代碼
  final int openAppButtonNameCode;
  // 是否允許搜尋 return data['searchable'] == 1;
  final int searchable;

  const ItemData(
      {required this.id,
      required this.category,
      required this.creatorId,
      required this.createQuantity,
      required this.createTime,
      required this.floatPosition,
      required this.forbidden,
      required this.name,
      required this.collectable,
      required this.expiration,
      required this.subcategory,
      required this.updateTimestamp,
      required this.openAppButtonNameCode,
      required this.searchable});

  factory ItemData.fromJson(Map<String, dynamic> json) =>
      _$ItemDataFromJson(json);
}
