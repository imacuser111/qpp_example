import 'package:qpp_example/model/enum/item/nft_section_type.dart';
import 'package:qpp_example/model/nft/nft_trait.dart';

/// 存放要在前端顯示的資料
class NFTAttributes {
  /// 全部的資料
  late final List<NFTTrait> _attributes = [];
  late final List<NFTTrait> _description = [];
  late final List<NFTTrait> _properties = [];
  late final List<NFTTrait> _stats = [];
  late final List<NFTTrait> _levels = [];
  late final List<NFTTrait> _boost = [];
  late final List<NFTTrait> _date = [];

  NFTAttributes.create(List<dynamic> json) {
    for (var trait in json) {
      var nftTrait = NFTTrait.create(trait);
      _attributes.add(nftTrait);
      NFTSectionType type = nftTrait.sectionType;
      switch (type) {
        case NFTSectionType.description:
          _description.add(nftTrait);
          break;
        case NFTSectionType.properties:
          _properties.add(nftTrait);
          break;
        case NFTSectionType.stats:
          _stats.add(nftTrait);
          break;
        case NFTSectionType.levels:
          _levels.add(nftTrait);
          break;
        case NFTSectionType.boost:
          _boost.add(nftTrait);
          break;
        case NFTSectionType.date:
          _date.add(nftTrait);
          break;
        case _:
          break;
      }
    }
  }

  List<NFTTrait> get descriptionSection {
    return _description;
  }

  List<NFTTrait> get propertiesSection {
    return _properties;
  }

  List<NFTTrait> get statsSection {
    return _stats;
  }

  List<NFTTrait> get levelsSection {
    return _levels;
  }

  List<NFTTrait> get boostSection {
    return _boost;
  }

  List<NFTTrait> get dateSection {
    return _date;
  }

  addDescription(NFTTrait description) {
    _description.add(description);
  }
}
