

/// 外部連結類型
enum UniversalLinkType {
    unknown,
    /// 帶幣登入
    login,
    /// 外部登入
    vendorLogin,
    /// 授權(動態牆)登入權限
    loginAuth,
    /// 綜合出示
    comprehensiveInfo,
    /// 用戶資訊
    userInformation,
    /// 賣家市集資訊
    marketInfo,
    /// 上架單資訊
    orderInfo,
    /// 物品資訊
    commodityInfo,
    /// NFT物品資訊
    nftInfo,
    /// 物品出示
    commodityWithToken,
    /// 主動領取(身份識別)(舊格式，已由物品資訊取代)
    membershipfetch,
    /// 顯示OTP token
    otpDisplay,
    /// 移轉物品請求
    commodityRequest,
    /// 外部用Intent跟Scheme的方式請求Token
    requestTokenByApp
}

extension UniversalLinkTypeExtension on UniversalLinkType {
  String get value {
    return switch (this) {
    UniversalLinkType.unknown => "",
    UniversalLinkType.login => "login",
    UniversalLinkType.vendorLogin => "vendor_login",
    UniversalLinkType.loginAuth => "login_auth",
    UniversalLinkType.comprehensiveInfo => "info",
    UniversalLinkType.userInformation => "information",
    UniversalLinkType.marketInfo => "market_info",
    UniversalLinkType.orderInfo => "order_info",
    UniversalLinkType.commodityInfo => "commodity_info",
    UniversalLinkType.nftInfo => "nft_info",
    UniversalLinkType.commodityWithToken => "commodity_with_token",
    UniversalLinkType.membershipfetch => "membership_fetch",
    UniversalLinkType.otpDisplay => "otp_display",
    UniversalLinkType.commodityRequest => "commodity_request",
    UniversalLinkType.requestTokenByApp => "request_token_by_app"
    };
  }
}