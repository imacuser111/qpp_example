import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/api/core/http_service.dart';
import 'package:qpp_example/api/item_api.dart';
import 'package:qpp_example/api/podo/core/base_response.dart';
import 'package:qpp_example/api/podo/item_select.dart';
import 'package:qpp_example/api/podo/multi_language_item_description_select.dart';
import 'package:qpp_example/api/podo/multi_language_item_intro_link_select.dart';
import 'package:qpp_example/api/podo/user_select_info.dart';

class CommodityInfoModel extends ChangeNotifier {
  /// 物品資訊
  ApiResponse<ItemData> itemSelectInfoState = ApiResponse.initial();

  /// 物品資訊
  ApiResponse<MultiLanguageItemDescriptionData> itemDescriptionInfoState =
      ApiResponse.initial();

  /// 物品資訊
  ApiResponse<MultiLanguageItemIntroLinkData> itemLinkInfoState =
      ApiResponse.initial();

  /// 創建者資訊狀態
  ApiResponse<UserSelectInfoResponse> userInfoState = ApiResponse.initial();

  /// 頭像狀態
  ApiResponse<String> avatarState = ApiResponse.initial();

  loadData(String id) {
    HttpService service = HttpService.instance;
    Dio dio = service.dio;
    final client = ItemApi(dio);
    getItemInfo(client, id);
    getMultiLanguageItemDescription(client, id);
    getMultiLanguageItemIntroLink(client, id);
  }

  /// 取得物品資訊
  getItemInfo(ItemApi client, String id) {
    itemSelectInfoState = ApiResponse.loading();
    notifyListeners();

    String requestBody = ItemSelectRequest().createItemSelectBody([id]);

    client.postItemSelect(requestBody).then((itemSelectResponse) {
      if (itemSelectResponse.errorCode == "OK") {
        ItemData itemData = itemSelectResponse.getItem(0);
        itemSelectInfoState = ApiResponse.completed(itemData);
        // 取物品資訊成功後, 取得創建者資料
        int? id = itemSelectInfoState.data?.creatorId;
        getUserInfo(id!);
      } else {
        itemSelectInfoState = ApiResponse.error(itemSelectResponse.errorCode);
        print('取得物品資訊錯誤 SERVER_ERROR_CODE: ${itemSelectResponse.errorCode}');
      }
      notifyListeners();
    }).catchError((error) {
      itemSelectInfoState = ApiResponse.error(error);
      notifyListeners();
      print('取得物品資訊錯誤: $error');
    });
  }

  /// 取得物品說明資訊
  getMultiLanguageItemDescription(ItemApi client, String id) {
    itemDescriptionInfoState = ApiResponse.loading();
    notifyListeners();
    String requestBody =
        MultiLanguageItemDescriptionSelectRequest().createBody(id);

    client
        .postMultiLanguageItemDescriptionSelect(requestBody)
        .then((descriptionResponse) {
      if (descriptionResponse.errorCode == "OK") {
        MultiLanguageItemDescriptionData descriptionData =
            descriptionResponse.descriptionData;
        itemDescriptionInfoState = ApiResponse.completed(descriptionData);
      } else {
        itemDescriptionInfoState =
            ApiResponse.error(descriptionResponse.errorCode);
        print('取得物品說明資訊錯誤 SERVER_ERROR_CODE: ${descriptionResponse.errorCode}');
      }
      notifyListeners();
    }).catchError((error) {
      itemDescriptionInfoState = ApiResponse.error(error);
      notifyListeners();
      print('取得物品說明資訊錯誤: $error');
    });
  }

  /// 取得物品連結資訊
  getMultiLanguageItemIntroLink(ItemApi client, String id) {
    itemLinkInfoState = ApiResponse.loading();
    notifyListeners();
    String requestBody =
        MultiLanguageItemIntroLinkSelectRequest().createBody(id);

    client
        .postMultiLanguageItemIntroLinkSelect(requestBody)
        .then((introLinkResponse) {
      if (introLinkResponse.errorCode == "OK") {
        MultiLanguageItemIntroLinkData introLinkData =
            introLinkResponse.introLinkData;
        itemLinkInfoState = ApiResponse.completed(introLinkData);
      } else {
        itemLinkInfoState = ApiResponse.error(introLinkResponse.errorCode);
        print('取得物品連結資訊錯誤 SERVER_ERROR_CODE: ${introLinkResponse.errorCode}');
      }
      notifyListeners();
    }).catchError((error) {
      itemLinkInfoState = ApiResponse.error(error);
      notifyListeners();
      print('取得物品連結資訊錯誤: $error');
    });
  }

  /// 取得用戶資訊
  getUserInfo(int userID) {
    userInfoState = ApiResponse.loading();
    notifyListeners();

    final request = UserSelectInfoRequest(userID);

    request.request(successCallBack: (data) {
      if (data.errorCode == "OK") {
        userInfoState = ApiResponse.completed(data.userSelectInfoResponse);
      } else {
        userInfoState = ApiResponse.error(data.errorCode);
        print('取得創建者用戶資訊錯誤 SERVER_ERROR_CODE: ${data.errorCode}');
      }
      notifyListeners();
    }, errorCallBack: (error) {
      userInfoState = ApiResponse.error(error);
      notifyListeners();
    });
  }

  /// 取得用戶圖片
  // getUserImage(int userID, {QppImageStyle style = QppImageStyle.avatar}) {
  //   bool isAvater = style == QppImageStyle.avatar;

  //   isAvater
  //       ? avaterState = ApiResponse.loading()
  //       : bgImageState = ApiResponse.loading();

  //   final request = GetUserImageRequest(userID, style);

  //   request.request(successCallBack: (data) {
  //     isAvater
  //         ? avaterState = ApiResponse.completed(data)
  //         : bgImageState = ApiResponse.completed(data);
  //   }, errorCallBack: (error) {
  //     isAvater
  //         ? avaterState = ApiResponse.error(error)
  //         : bgImageState = ApiResponse.error(error);
  //   });
  // }

  String get imgUrl {
    return '';
  }
}
