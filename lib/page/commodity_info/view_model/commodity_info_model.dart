import 'package:flutter/foundation.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/api/client_api.dart';
import 'package:qpp_example/api/podo/item_select.dart';
import 'package:qpp_example/api/podo/multi_language_item_data.dart';
import 'package:qpp_example/api/podo/multi_language_item_description_select.dart';
import 'package:qpp_example/api/podo/multi_language_item_intro_link_select.dart';
import 'package:qpp_example/api/podo/user_select_info.dart';
import 'package:qpp_example/model/item_img_data.dart';
import 'package:qpp_example/model/item_multi_language_data.dart';
import 'package:qpp_example/model/qpp_item.dart';
import 'package:qpp_example/model/qpp_user.dart';
import 'package:qpp_example/utils/qpp_image_utils.dart';

/// 物品資訊頁 model
class CommodityInfoModel extends ChangeNotifier {
  /// 物品資訊
  ApiResponse<QppItem> itemSelectInfoState = ApiResponse.initial();

  /// 物品多語系說明資訊
  ApiResponse<ItemMultiLanguageData> itemDescriptionInfoState =
      ApiResponse.initial();

  /// 物品多語系連結資訊
  ApiResponse<ItemMultiLanguageData> itemLinkInfoState = ApiResponse.initial();

  /// 創建者資訊狀態
  ApiResponse<QppUser> userInfoState = ApiResponse.initial();

  /// 物品圖片狀態
  ApiResponse<ItemImgData> itemPhotoState = ApiResponse.initial();

  final client = ClientApi.client;

  loadData(String id) {
    debugPrint('開始取得物品資訊...');
    getItemInfo(id);
    getMultiLanguageItemDescription(id);
    getMultiLanguageItemIntroLink(id);
  }

  /// 取得物品資訊
  getItemInfo(String id) {
    itemSelectInfoState = ApiResponse.loading();
    notifyListeners();

    String requestBody = ItemSelectRequest().createItemSelectBody([id]);

    client.postItemSelect(requestBody).then((itemSelectResponse) {
      if (itemSelectResponse.errorCode == "OK") {
        ItemData itemData = itemSelectResponse.getItem(0);
        QppItem item = QppItem.create(itemData);
        itemSelectInfoState = ApiResponse.completed(item);
        // 取物品資訊成功後, 取得創建者資料
        int? creatorId = itemSelectInfoState.data?.creatorId;
        getUserInfo(creatorId!);
        getItemImage(creatorId);
      } else {
        itemSelectInfoState = ApiResponse.error(itemSelectResponse.errorCode);
        print('取得物品資訊錯誤 SERVER_ERROR_CODE: ${itemSelectResponse.errorCode}');
      }
      notifyListeners();
    }).catchError((error) {
      // 無此物品
      itemSelectInfoState = ApiResponse.error(error);
      notifyListeners();
      print('取得物品資訊錯誤: $error');
    });
  }

  /// 取得物品說明資訊
  getMultiLanguageItemDescription(String id) {
    itemDescriptionInfoState = ApiResponse.loading();
    notifyListeners();
    String requestBody =
        MultiLanguageItemDescriptionSelectRequest().createBody(id);

    client
        .postMultiLanguageItemDescriptionSelect(requestBody)
        .then((descriptionResponse) {
      if (descriptionResponse.errorCode == "OK") {
        MultiLanguageItemData descriptionData =
            descriptionResponse.descriptionData;
        ItemMultiLanguageData itemDescription =
            ItemMultiLanguageData.description(descriptionData);
        itemDescriptionInfoState = ApiResponse.completed(itemDescription);
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
  getMultiLanguageItemIntroLink(String id) {
    itemLinkInfoState = ApiResponse.loading();
    notifyListeners();
    String requestBody =
        MultiLanguageItemIntroLinkSelectRequest().createBody(id);

    client
        .postMultiLanguageItemIntroLinkSelect(requestBody)
        .then((introLinkResponse) {
      if (introLinkResponse.errorCode == "OK") {
        MultiLanguageItemData introLinkData = introLinkResponse.introLinkData;
        ItemMultiLanguageData itemIntroLink =
            ItemMultiLanguageData.link(introLinkData);
        itemLinkInfoState = ApiResponse.completed(itemIntroLink);
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

    final request = UserSelectInfoRequest().createBody(userID.toString());

    client.postUserSelect(request).then((userSelectInfoResponse) {
      if (userSelectInfoResponse.errorCode == "OK") {
        // 取得創建用戶
        QppUser creator = QppUser.create(userID, userSelectInfoResponse);
        userInfoState = ApiResponse.completed(creator);
      } else {
        userInfoState = ApiResponse.error(userSelectInfoResponse.errorCode);
        print(
            '取得創建者用戶資訊錯誤 SERVER_ERROR_CODE: ${userSelectInfoResponse.errorCode}');
      }
      notifyListeners();
    }).catchError((error) {
      userInfoState = ApiResponse.error(error);
      notifyListeners();
    });
  }

  /// 取得物品圖片
  getItemImage(int creatorID) {
    var itemData = itemSelectInfoState.data!;
    var timeUTC = DateTime.now().millisecondsSinceEpoch;
    String itemPhotoUrl = QppImageUtils.getItemImageURL(creatorID, itemData.id,
        timeStamp: timeUTC);

    itemPhotoState = ApiResponse.completed(ItemImgData(itemPhotoUrl));
    notifyListeners();
  }
}
