class NftLinkData {
  late int type;
  late String website;
  late String downloadLink;
  late String androidPackageName;
  late String iOSAppId;
  late String urlSchemes;

  /// app 按鈕用, web 應該沒使用到
  NftLinkData.create(Map<String, dynamic> json) {
    type = json["typeInt"] ?? -1;
    website = json["website"] ?? "";
    downloadLink = json["downloadLink"] ?? "";
    androidPackageName = json["androidPackageName"] ?? "";
    iOSAppId = json["iosAppId"] ?? "";
    urlSchemes = json["urlSchemes"] ?? "";
  }
}
