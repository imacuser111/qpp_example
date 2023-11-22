class NftLinkData {
  late int type;
  late String website;
  late String downloadLink;
  late String androidPackageName;
  late String iOSAppId;
  late String urlSchemes;

  NftLinkData.create(Map<String, dynamic> json) {
    type = json["typeInt"] ?? -1;
    website = json["website"] ?? "";
    downloadLink = json["downloadLink"] ?? "";
    androidPackageName = json["androidPackageName"] ?? "";
    iOSAppId = json["iosAppId"] ?? "";
    urlSchemes = json["urlSchemes"] ?? "";
  }
}
