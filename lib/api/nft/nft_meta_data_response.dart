/// NFT meta data 請求資訊
// ignore_for_file: non_constant_identifier_names

class NftMetaDataResponse {
  final Map<String, dynamic> json;

  const NftMetaDataResponse({required this.json});

  factory NftMetaDataResponse.fromJson(Map<String, dynamic> json) {
    return NftMetaDataResponse(
      json: json,
    );
  }

  String get publisher {
    return json['publisher'];
  }

  String get name {
    return json['name'];
  }

  String get description {
    return json['description'];
  }

  String get external_url {
    return json['external_url'];
  }

  String get image {
    return json['image'];
  }

  String get background_color {
    return json['background_color'];
  }

  /// 舊的 NFT 資料可能沒有這個屬性
  String get tag {
    return json['tag'] ?? "";
  }

  List<dynamic> get attributes {
    return json['attributes'];
  }

  Map<String, dynamic> get exchangeData {
    return json['exchangeData'];
  }

  Map<String, dynamic> get linkData {
    return json['linkData'];
  }
}
