import 'package:qpp_example/api/nft/nft_meta_data_response.dart';
import 'package:qpp_example/model/nft/nft_attributes.dart';
import 'package:qpp_example/model/nft/nft_exchange_data.dart';
import 'package:qpp_example/model/nft/nft_link_data.dart';
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
  }

  /// NFT 圖片背景顏色
  get backgroundColor {
    return _backgroundColor;
  }
}
