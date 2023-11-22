import 'package:qpp_example/constants/server_const.dart';

enum PlayStoreType {
  google,
  apple;

  String get image {
    return switch (this) {
      PlayStoreType.google => 'btn-google.png',
      PlayStoreType.apple => 'btn-apple.png'
    };
  }

  String get url {
    return switch (this) {
      PlayStoreType.google => ServerConst.googlePlayStoreUrl,
      PlayStoreType.apple => ServerConst.appleStoreUrl
    };
  }
}

/// 特色資訊類型
enum HomePageFeatureInfoType {
  /// 虛寶
  virtual,

  /// 身份識別
  identification,

  /// 票券
  voucher,

  /// 更多
  more
}

/// 特色資訊類型 - 參數值
extension HomePageFeatureInfoTypeValues on HomePageFeatureInfoType {
  String get title {
    switch (this) {
      case HomePageFeatureInfoType.virtual:
        return '遊戲虛寶自由移轉';
      case HomePageFeatureInfoType.identification:
        return '安心保存會員卡';
      case HomePageFeatureInfoType.voucher:
        return '票券暢行無阻礙';
      case HomePageFeatureInfoType.more:
        return '更多豐富功能等你挖掘';
    }
  }

  String get directions {
    switch (this) {
      case HomePageFeatureInfoType.virtual:
        return '合作夥伴的遊戲虛寶，將可任你移轉給他人兌換使用，不再被遊戲限制給束縛住！';
      case HomePageFeatureInfoType.identification:
        return '透過最先進的資料儲存技術，QPP 可快速發行各類數位會員卡，取代紙本會員卡保存不易的問題！';
      case HomePageFeatureInfoType.voucher:
        return '門票、折價劵不怕弄丟，通通存進QPP數位背包內，一鍵使用輕鬆享受！';
      case HomePageFeatureInfoType.more:
        return 'QPP的目標是成為全球最大的虛實整合平台。還可透過先進 SDK 串接，還可解鎖更多獨家功能！';
    }
  }

  String get image {
    switch (this) {
      case HomePageFeatureInfoType.virtual:
        return 'desktop_icon_area01_01_pressed.svg';
      case HomePageFeatureInfoType.identification:
        return 'desktop_icon_area01_02_nomal.svg';
      case HomePageFeatureInfoType.voucher:
        return 'desktop_icon_area01_03_normal.svg';
      case HomePageFeatureInfoType.more:
        return 'desktop_icon_area01_04_normal.svg';
    }
  }
}

/// 使用說明類型
enum HomePageDescriptionType {
  /// 手機
  phone,

  /// 通訊錄
  directory,

  /// 討論區
  forum
}

/// 使用說明類型 - 參數值
extension HomePageDescriptionValues on HomePageDescriptionType {
  String get title {
    switch (this) {
      case HomePageDescriptionType.phone:
        return '手機門號就是QPP帳號';
      case HomePageDescriptionType.directory:
        return '一鍵匯入通訊錄名單';
      case HomePageDescriptionType.forum:
        return '輕鬆交流的討論區';
    }
  }

  String get directions {
    switch (this) {
      case HomePageDescriptionType.phone:
        return '物品移轉不需要對方有用過QPP即可輕鬆發送，系統會發簡訊通知對方有物品轉入，透過簡訊登入QPP即可使用物品，無縫接軌省去繁瑣註冊流程。';
      case HomePageDescriptionType.directory:
        return '只要將手機聯絡人一鍵匯入，就能把好友拉進你的QPP 生活圈，一起討論話題、交換物品、甚至領取更多獎勵，樂趣更多好處也更多！';
      case HomePageDescriptionType.forum:
        return '每位用戶都擁有專屬的個人討論專頁，可以輕鬆發起話題並與人交流。不論是生活情報、購物好康、還是八卦話題，都能在 QPP 上找到同伴！';
    }
  }

  String get image {
    switch (this) {
      case HomePageDescriptionType.phone:
        return 'desktop_pic_area02_01.webp';
      case HomePageDescriptionType.directory:
        return 'desktop_pic_area02_02.webp';
      case HomePageDescriptionType.forum:
        return 'desktop_pic_area02_03.webp';
    }
  }

  /// 內容在右邊
  bool get conetntOfRight {
    switch (this) {
      case HomePageDescriptionType.phone || HomePageDescriptionType.forum:
        return true;
      case HomePageDescriptionType.directory:
        return false;
    }
  }
}

/// 使用說明類型
enum HomePageContactType { first, second, third }

/// 使用說明類型 - 參數值
extension HomePageContactTypeValues on HomePageContactType {
  String get title {
    switch (this) {
      case HomePageContactType.first:
        return '數位物品大量創建發送';
      case HomePageContactType.second:
        return '告別帳號密碼的時代';
      case HomePageContactType.third:
        return '兌換就是那麼簡單';
    }
  }

  String get directions {
    switch (this) {
      case HomePageContactType.first:
        return '輕鬆將您創建的數位物品發送給大量用戶。';
      case HomePageContactType.second:
        return '讓用戶在高安全環境下登入您的服務。';
      case HomePageContactType.third:
        return '從此用戶不用輸入亂碼來兌換虛擬商品或優惠。';
    }
  }

  /// 內容在上方
  bool get contentOfTop {
    switch (this) {
      case HomePageContactType.first || HomePageContactType.third:
        return true;
      case HomePageContactType.second:
        return false;
    }
  }
}
