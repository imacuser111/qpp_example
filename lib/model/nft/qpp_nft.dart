import 'package:flutter/material.dart';
import 'package:qpp_example/api/nft/nft_meta_data_response.dart';
import 'package:qpp_example/extension/string/text.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/model/nft/nft_attributes.dart';
import 'package:qpp_example/model/nft/nft_exchange_data.dart';
import 'package:qpp_example/model/nft/nft_link_data.dart';
import 'package:qpp_example/model/nft/nft_trait.dart';
import 'package:qpp_example/utils/invitation_utils.dart';

class QppNFT {
  /// 發行者 邀請碼
  late String publisherInviteCode;

  /// 發行者 ID
  late String publisherID;
  late String tag;
  late String name;
  late String description;
  late String externalUrl;
  late String image;
  late String _backgroundColor;

  late NFTAttributes attributes;
  late NFTExchangeData exchangeData;
  late NftLinkData linkData;

  QppNFT.create(NftMetaDataResponse data) {
    publisherInviteCode = data.publisher;
    tag = data.tag;
    name = data.name;
    description = data.description;
    externalUrl = data.external_url;
    image = data.image;
    _backgroundColor = data.background_color;
    exchangeData = NFTExchangeData.create(data.exchangeData);
    linkData = NftLinkData.create(data.linkData);
    attributes = NFTAttributes.create(data.attributes);
    // 邀請碼轉換為發行者 ID
    publisherID = InvitationUtils.invitationCodeToUserId(publisherInviteCode);

    // TODO: 下面資料需要這時候給? (多語系要 build context)
    // TODO: 取得用戶名稱...call api
    // 發行者 多語系 key  QppLocales.commodityInfoPublisher
    attributes.addDescription(NFTTrait.createDescription(
        "QppLocales.commodityInfoPublisher", publisherID));
    if (!externalUrl.isNullOrEmpty) {
      // 連結 多語系 key QppLocales.commodityInfoTitle
      attributes.addDescription(NFTTrait.createDescription(
          "QppLocales.commodityInfoTitle", externalUrl));
    }
    if (!description.isNullOrEmpty) {
      // 説明 多語系 key QppLocales.commodityInfoInfo
      attributes.addDescription(NFTTrait.createDescription(
          "QppLocales.commodityInfoInfo", description));
    }
  }

  /// NFT 圖片背景顏色
  get backgroundColor {
    // int colorIndex = int.parse('0xFF$_backgroundColor');
    // return Color(colorIndex);
    return _backgroundColor;
  }
}
