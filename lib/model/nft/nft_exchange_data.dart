class NFTExchangeData {
  late int type;
  late int textIndex;

  /// app 用, web 似乎沒使用
  NFTExchangeData.create(Map<String, dynamic> json) {
    type = json["typeInt"] ?? -1;
    textIndex = json["textIndex"] ?? -1;
  }
}
