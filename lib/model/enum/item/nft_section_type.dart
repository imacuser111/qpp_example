/// Section 類型
/// PS.順序為UI定義
enum NFTSectionType {
  description(0),
  properties(1),
  stats(2),
  levels(3),
  boost(4),
  date(5),
  none(-1);

  final int value;
  const NFTSectionType(this.value);

  /// 取出指定的值
  static NFTSectionType findTypeByValue(int value) {
    for (var sectionType in NFTSectionType.values) {
      if (sectionType.value == value) {
        return sectionType;
      }
    }
    return NFTSectionType.none;
  }

  /// 使用server的 displayType 轉換成client端的類型
  static NFTSectionType findTypeByDisplayValue(String noteType) {
    return switch (noteType) {
      "number" => NFTSectionType.stats,
      "boost_number" => NFTSectionType.boost,
      "boost_percentage" => NFTSectionType.boost,
      "date" => NFTSectionType.date,
      _ => NFTSectionType.none
    };
  }

  /// 取得標題文字
  String get title {
    return switch (this) {
      NFTSectionType.description => "Description",
      NFTSectionType.properties => "Properties",
      NFTSectionType.stats => "Stats",
      NFTSectionType.levels => "Levels",
      NFTSectionType.boost => "Boosts",
      NFTSectionType.date => "Date",
      _ => " ",
    };
  }

  /// 取得nft標題欄位的icon  todo 要搬走
  // @DrawableRes
  //  int getNftTitleDrawableId() {
  //     switch (this) {
  //         case DESCRIPTION:
  //             return R.drawable.icon_commodity_nft_describe;
  //         case PROPERTIES:
  //             return R.drawable.icon_commodity_nft_properties;
  //         case STATS:
  //             return R.drawable.icon_commodity_nft_stats;
  //         case LEVELS:
  //             return R.drawable.icon_commodity_nft_levels;
  //         case BOOST:
  //             return R.drawable.icon_commodity_nft_boosts;
  //         case DATE:
  //             return R.drawable.icon_commodity_nft_date;
  //         default:
  //             return 0;
  //     }
  // }
}
