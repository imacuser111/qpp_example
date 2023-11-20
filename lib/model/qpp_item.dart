import 'package:qpp_example/api/client/item_select.dart';
import 'package:qpp_example/model/enum/item/item_category.dart';
import 'package:qpp_example/model/enum/item/item_sub_category.dart';

class QppItem {
  late ItemCategory category;
  late ItemSubCategory subCategory;
  late int createQuantity;
  late int createTime;
  late int creatorId;
  late int expiration;
  late int floatPosition;
  late bool forbidden;
  late int id;
  late String name;
  late int openAppButtonNameCode;
  late bool searchable;
  late int updateTimestamp;

  QppItem.create(ItemData data) {
    category = ItemCategory.findTypeByValue(data.category);
    subCategory = ItemSubCategory.findTypeByValue(data.subcategory);
    createQuantity = data.createQuantity;
    createTime = data.createTime;
    creatorId = data.creatorId;
    expiration = data.expiration;
    floatPosition = data.floatPosition;
    forbidden = data.forbidden;
    id = data.id;
    name = data.name;
    openAppButtonNameCode = data.openAppButtonNameCode;
    searchable = data.isSearchable;
    updateTimestamp = data.updateTimestamp;
  }

  /// 取得物品類別 icon 位址
  String get categoryIconPath {
    if (category != ItemCategory.hiddenVoucher) {
      return category.iconPath;
    }
    return subCategory.iconPath;
  }

  /// 取得物品類別名稱
  String get categoryName {
    if (category != ItemCategory.hiddenVoucher) {
      return category.displayName;
    }
    return subCategory.displayName;
  }
}
