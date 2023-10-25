import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/api/core/http_service.dart';
import 'package:qpp_example/api/item_api.dart';
import 'package:qpp_example/api/podo/core/base_response.dart';
import 'package:qpp_example/api/podo/item_select.dart';
import 'package:qpp_example/api/podo/multi_language_item_description_select.dart';
import 'package:qpp_example/api/podo/multi_language_item_intro_link_select.dart';

class CommodityInfoModel extends ChangeNotifier {
  /// 物品資訊
  ApiResponse<ItemData> itemSelectInfoState = ApiResponse.initial();

  /// 頭像狀態
  ApiResponse<BaseResponse> avatarState = ApiResponse.initial();

  /// 取得物品資訊
  getItemInfo(String id) {
    itemSelectInfoState = ApiResponse.loading();
    notifyListeners();

    HttpService service = HttpService.instance;
    Dio dio = service.dio;
    final client = ItemApi(dio);
    String requestBody = ItemSelectRequest().createItemSelectBody([id]);

    client.postItemSelect(requestBody).then((itemSelectResponse) {
      ItemData itemData = itemSelectResponse.getItem(0);
      itemSelectInfoState = ApiResponse.completed(itemData);
      notifyListeners();
      print('Success');
    }).catchError((error) {
      itemSelectInfoState = ApiResponse.error(error);
      notifyListeners();
      print('get item data error: $error');
    }).whenComplete(() => getMultiLanguageItemDescription(client, id));
  }

  /// 取得物品說明資訊
  getMultiLanguageItemDescription(ItemApi client, String id) {
    String requestBody =
        MultiLanguageItemDescriptionSelectRequest().createBody(id);

    client
        .postMultiLanguageItemDescriptionSelect(requestBody)
        .then((descriptionResponse) {
      MultiLanguageItemDescriptionData descriptionData =
          descriptionResponse.descriptionData;
      print('Des Success');
    }).catchError((error) {
      itemSelectInfoState = ApiResponse.error(error);
      print('get item des data error: $error');
    }).whenComplete(() => getMultiLanguageItemIntroLink(client, id));
  }

  /// 取得物品連結資訊
  getMultiLanguageItemIntroLink(ItemApi client, String id) {
    String requestBody =
        MultiLanguageItemIntroLinkSelectRequest().createBody(id);

    client
        .postMultiLanguageItemIntroLinkSelect(requestBody)
        .then((introLinkResponse) {
      MultiLanguageItemIntroLinkData introLinkData =
          introLinkResponse.introLinkData;
      print('Intro Success');
    }).catchError((error) {
      itemSelectInfoState = ApiResponse.error(error);
      print('get item Intro data error: $error');
    });
  }

  String get imgUrl {
    return '';
  }
}
