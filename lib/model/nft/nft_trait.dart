import 'package:qpp_example/extension/string/text.dart';
import 'package:qpp_example/model/enum/item/nft_section_type.dart';

/// NFT 顯示區塊內的最小單位
class NFTTrait {
  late String _displayType;
  // 可能為 int or string
  late dynamic _value;
  // 可能為 int or string
  late dynamic _maxValue;

  late String _traitType;

  /// 顯示區塊的 type
  late NFTSectionType sectionType;

  /// server 收到的資料創建 trait
  NFTTrait.create(Map<String, dynamic> json) {
    _displayType = json["display_type"] ?? "";
    _value = json["value"] ?? "";
    _maxValue = json["max_value"] ?? "";
    _traitType = json["trait_type"] ?? "";
    _setSectionType();
  }

  /// 創建 description 區塊的 trait
  NFTTrait.createDescription(String traitType, String value) {
    _traitType = traitType;
    _value = value;
    sectionType = NFTSectionType.description;
  }

  String get value {
    if (_value is String) {
      return _value;
    }
    return _value.toString();
  }

  String get maxValue {
    if (_maxValue is String) {
      return _maxValue;
    }
    return _maxValue.toString();
  }

  String get displayType {
    return _displayType;
  }

  String get traitType {
    return _traitType;
  }

  /// 設定前端顯示區塊 type
  _setSectionType() {
    if (_displayType.isNullOrEmpty) {
      bool isString = _value is String;
      if (isString) {
        sectionType = NFTSectionType.properties;
      } else {
        sectionType = NFTSectionType.levels;
      }
    } else {
      sectionType = NFTSectionType.findTypeByDisplayValue(_displayType);
    }
  }
}
