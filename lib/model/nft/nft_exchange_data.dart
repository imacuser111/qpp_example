class NFTExchangeData {
  late int type;
  late int textIndex;

  NFTExchangeData.create(Map<String, dynamic> json) {
    type = json["typeInt"] ?? -1;
    textIndex = json["textIndex"] ?? -1;
  }
}
