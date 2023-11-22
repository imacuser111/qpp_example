enum NFTSectionType {
  DESCRIPTION(0),
  PROPERTIES(1),
  STATS(2),
  LEVELS(3),
  BOOST(4),
  DATE(5),
  NONE(-1);

  final int value;
  const NFTSectionType(this.value);
  // SectionType(int value)
  // {
  //     this.value = value;
  // }

  /**
         * 取得定義的值
         * @return
         */
  //  int getValue() {
  //     return value;
  // }

  /// 取出指定的值
  static NFTSectionType findTypeByValue(int value) {
    for (var sectionType in NFTSectionType.values) {
      if (sectionType.value == value) {
        return sectionType;
      }
    }
    return NFTSectionType.NONE;
  }

  /// 使用server的 type 轉換成client端的類型
  /// @param noteType
  //  static SectionType findTypeByNoteType(String noteType)
  // {
  //     switch (noteType)
  //     {
  //         case PROPERTIES:
  //             return SectionType.PROPERTIES;
  //         case STATS:
  //             return SectionType.STATS;
  //         case RANKING:
  //             return SectionType.LEVELS;
  //         case DATE:
  //             return SectionType.DATE;
  //         case BOOSTS_NUMBER:
  //         case BOOSTS_PERCENTAGE:
  //             return SectionType.BOOST;
  //         default:
  //             return NONE;
  //     }
  // }

  /// 取得標題文字
  //  String getTitle() {
  //     switch (this) {
  //         case DESCRIPTION:
  //             return "Description";
  //         case PROPERTIES:
  //             return "Properties";
  //         case STATS:
  //             return "Stats";
  //         case LEVELS:
  //             return "Levels";
  //         case BOOST:
  //             return "Boosts";
  //         case DATE:
  //             return "Date";
  //         default:
  //             return com.qpptec.QPP.utils.StringUtils.getString(R.string.ID_Error);
  //     }
  // }

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
