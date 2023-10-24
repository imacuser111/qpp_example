import 'package:flutter/foundation.dart';

// server 常數放置

/// 隱私權網址
const privacyPolicyUrl = "https://www.qpptec.com/privacy?lang=%s";

/// 使用條款網址
const termsOfUseUrl = "https://www.qpptec.com/term?lang=%s";

/// 跨境燃料費 url
const crossBorderFueCostUrl =
    "https://www.qpptec.com/nft_info_teach/?lang=%s&anchor=cross-border";

/// 入境 url
const importUrl = "https://www.qpptec.com/nft_info_teach/?lang=%s&anchor=entry";

/// AppLink url
const appLinkUrl = "https://qpptec.com/app/";

// kReleaseMode 若在 release -> true / 若在 debug & profile -> false

/// Storage api 位址 正式 / 測試
const storage = kReleaseMode
    ? "https://storage.googleapis.com/qpp_blockchain/"
    : "https://storage.googleapis.com/qpp_blockchain_test/";

// /// GCP AP I- 正式 / 測試
const apiUrl = kDebugMode
    ? "https://pro2-api.qpptec.com/client/"
    : "https://dev2-api.qpptec.com/client/";

/// Polygonscan位址
const polygonUrl = "https://polygonscan.com/tx/";

/// ethereum 正式 / 測試  url
const ethereumUrl = kReleaseMode
    ? "https://etherscan.io/tx/"
    : "https://goerli.etherscan.io/tx/";

/// ethereum 正式 / 測試  地址
const chainAddressEthereum = kReleaseMode
    ? "0x3dbeb39b1f87bcd85a66ea8f6a69ffaf87157b0d"
    : "0x77263fd6b4eeadc1932ddf4b9eb7d38e3466628e";
