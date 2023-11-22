import 'package:qpp_example/extension/string/text.dart';
import 'package:qpp_example/model/nft/nft_section_type.dart';

class NFTTrait {
  late String _displayType;
  // 可能為 int or string
  late dynamic _value;
  // 可能為 int or string
  late dynamic _maxValue;

  late String _traitType;

  late NFTSectionType sectionType;

  NFTTrait.create(Map<String, dynamic> json) {
    _displayType = json["display_type"] ?? "";
    _value = json["value"] ?? "";
    _maxValue = json["max_value"] ?? "";
    _traitType = json["trait_type"] ?? "";
    // _setSectionType();
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

  _setSectionType(dynamic value) {
    if (displayType.isNullOrEmpty) {
      bool isString = value is String;
      if (isString) {
        sectionType = NFTSectionType.PROPERTIES;
      } else {
        sectionType = NFTSectionType.LEVELS;
      }
    } else {
      sectionType = NFTSectionType.findTypeByValue(value);
    }
  }
}
