import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/utils/screen.dart';

/// 應用程式商店類型
enum PlayStoreType {
  google,
  apple;

  String get image {
    return switch (this) {
      PlayStoreType.google => 'assets/desktop-pic-platform-googleplay.webp',
      PlayStoreType.apple => 'assets/desktop-pic-platform-appstore.webp'
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
  more;

  String get title {
    switch (this) {
      case HomePageFeatureInfoType.virtual:
        return QppLocales.homeSection2Item1Title;
      case HomePageFeatureInfoType.identification:
        return QppLocales.homeSection2Item2Title;
      case HomePageFeatureInfoType.voucher:
        return QppLocales.homeSection2Item3Title;
      case HomePageFeatureInfoType.more:
        return QppLocales.homeSection2Item4Title;
    }
  }

  String get directions {
    switch (this) {
      case HomePageFeatureInfoType.virtual:
        return QppLocales.homeSection2Item1P;
      case HomePageFeatureInfoType.identification:
        return QppLocales.homeSection2Item2P;
      case HomePageFeatureInfoType.voucher:
        return QppLocales.homeSection2Item3P;
      case HomePageFeatureInfoType.more:
        return QppLocales.homeSection2Item4P;
    }
  }

  String get image {
    switch (this) {
      case HomePageFeatureInfoType.virtual:
        return 'assets/desktop-icon-area-01-01-normal.svg';
      case HomePageFeatureInfoType.identification:
        return 'assets/desktop-icon-area-01-02-nomal.svg';
      case HomePageFeatureInfoType.voucher:
        return 'assets/desktop-icon-area-01-03-normal.svg';
      case HomePageFeatureInfoType.more:
        return 'assets/desktop-icon-area-01-04-normal.svg';
    }
  }

  String get highlightImage {
    switch (this) {
      case HomePageFeatureInfoType.virtual:
        return 'assets/desktop-icon-area-01-01-pressed.svg';
      case HomePageFeatureInfoType.identification:
        return 'assets/desktop-icon-area-01-02-pressed.svg';
      case HomePageFeatureInfoType.voucher:
        return 'assets/desktop-icon-area-01-03-pressed.svg';
      case HomePageFeatureInfoType.more:
        return 'assets/desktop-icon-area-01-04-pressed.svg';
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
  forum;

  String get title {
    switch (this) {
      case HomePageDescriptionType.phone:
        return QppLocales.homeSection4Brik1Title;
      case HomePageDescriptionType.directory:
        return QppLocales.homeSection4Brik2Title;
      case HomePageDescriptionType.forum:
        return QppLocales.homeSection4Brik3Title;
    }
  }

  String get directions {
    switch (this) {
      case HomePageDescriptionType.phone:
        return QppLocales.homeSection4Brik1P;
      case HomePageDescriptionType.directory:
        return QppLocales.homeSection4Brik2P;
      case HomePageDescriptionType.forum:
        return QppLocales.homeSection4Brik3P;
    }
  }

  String image(ScreenStyle screenStyle) {
    final isDesktopStyle = screenStyle.isDesktop;

    switch (this) {
      case HomePageDescriptionType.phone:
        return 'assets/${isDesktopStyle ? 'desktop-pic-area-02-01' : 'mobile-pic-area-02-01'}.webp';
      case HomePageDescriptionType.directory:
        return 'assets/${isDesktopStyle ? 'desktop-pic-area-02-02' : 'mobile-pic-area-02-02'}.webp';
      case HomePageDescriptionType.forum:
        return 'assets/${isDesktopStyle ? 'desktop-pic-area-02-03' : 'mobile-pic-area-02-03'}.webp';
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

/// 聯絡我們類型
enum HomePageContactType {
  first,
  second,
  third;

  String get title {
    switch (this) {
      case HomePageContactType.first:
        return QppLocales.homeDigibagList1Name;
      case HomePageContactType.second:
        return QppLocales.homeDigibagList2Name;
      case HomePageContactType.third:
        return QppLocales.homeDigibagList3Name;
    }
  }

  String get directions {
    switch (this) {
      case HomePageContactType.first:
        return QppLocales.homeDigibagList1P;
      case HomePageContactType.second:
        return QppLocales.homeDigibagList2P;
      case HomePageContactType.third:
        return QppLocales.homeDigibagList3P;
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
