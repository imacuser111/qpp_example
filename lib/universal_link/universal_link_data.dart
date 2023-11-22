import 'package:json_annotation/json_annotation.dart';
part 'universal_link_data.g.dart';

/// univerSalLink參數資料
@JsonSerializable()
class UniversalLinkParamData {
  /// 使用者id(EX:886900100100 電話號碼)
  String? userID;

  /// 電話號碼
  String? phoneNumber;

  /// 物品id
  String? commodityID;

  /// 語系
  String? lang;

  /// 廠商ID
  String? vendorID;

  /// 廠商token
  String? vendorToken;

  /// 序號
  String? serial;

  /// 開啟外部瀏覽器(0/1)
  String? openExternalBrowser;

  UniversalLinkParamData(
      this.phoneNumber, this.userID, this.commodityID, this.lang);

  factory UniversalLinkParamData.fromJson(Map<String, dynamic> json) =>
      _$UniversalLinkParamDataFromJson(json);

  Map<String, dynamic> toJson() => _$UniversalLinkParamDataToJson(this);
}
