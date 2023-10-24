
enum PlayStoreType { android, iOS }

/// 特色資訊類型
enum FeatureInfoType {
  /// 虛寶
  virtual,

  /// 身份識別
  identification,

  /// 票券
  voucher,

  /// 更多
  more
}

extension FeatureInfoTypeValues on FeatureInfoType {
  String get title {
    switch (this) {
      case FeatureInfoType.virtual:
        return '遊戲虛寶自由移轉';
      case FeatureInfoType.identification:
        return '安心保存會員卡';
      case FeatureInfoType.voucher:
        return '票券暢行無阻礙';
      case FeatureInfoType.more:
        return '更多豐富功能等你挖掘';
    }
  }

  String get directions {
    switch (this) {
      case FeatureInfoType.virtual:
        return '合作夥伴的遊戲虛寶，將可任你移轉給他人兌換使用，不再被遊戲限制給束縛住！';
      case FeatureInfoType.identification:
        return '透過最先進的資料儲存技術，QPP 可快速發行各類數位會員卡，取代紙本會員卡保存不易的問題！';
      case FeatureInfoType.voucher:
        return '門票、折價劵不怕弄丟，通通存進QPP數位背包內，一鍵使用輕鬆享受！';
      case FeatureInfoType.more:
        return 'QPP的目標是成為全球最大的虛實整合平台。還可透過先進 SDK 串接，還可解鎖更多獨家功能！';
    }
  }

  String get image {
    switch (this) {
      case FeatureInfoType.virtual:
        return 'desktop_icon_area01_01_pressed.webp';
      case FeatureInfoType.identification:
        return 'desktop_icon_area01_02_nomal.webp';
      case FeatureInfoType.voucher:
        return 'desktop_icon_area01_03_normal.webp';
      case FeatureInfoType.more:
        return 'desktop_icon_area01_04_normal.webp';
    }
  }
}