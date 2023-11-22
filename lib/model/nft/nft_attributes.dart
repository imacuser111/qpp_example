import 'package:qpp_example/model/nft/nft_trait.dart';

class NFTAttributes {
  late List<NFTTrait> attributes = [];

  

  NFTAttributes.create(List<dynamic> json) {
    for (var trait in json) {
      var nftTrait = NFTTrait.create(trait);
      attributes.add(nftTrait);
    }
    print('test ');
  }
}

/// Section 類型
/// PS.順序為UI定義


