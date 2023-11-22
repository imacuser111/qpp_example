import 'package:qpp_example/api/nft/nft_meta_data_response.dart';
import 'package:qpp_example/model/nft/nft_attributes.dart';
import 'package:qpp_example/model/nft/nft_exchange_data.dart';
import 'package:qpp_example/model/nft/nft_link_data.dart';

class NFT {
  late String publisher;
  late String tag;
  late String name;
  late String description;
  late String externalUrl;
  late String image;
  late String backgroundColor;

  late NFTAttributes attributes;
  late NFTExchangeData exchangeData;
  late NftLinkData linkData;

  NFT.create(NftMetaDataResponse data) {
    publisher = data.publisher;
    tag = data.tag;
    name = data.name;
    description = data.description;
    externalUrl = data.external_url;
    image = data.image;
    backgroundColor = data.background_color;
    exchangeData = NFTExchangeData.create(data.exchangeData);
    linkData = NftLinkData.create(data.linkData);
    attributes = NFTAttributes.create(data.attributes);
  }
}
