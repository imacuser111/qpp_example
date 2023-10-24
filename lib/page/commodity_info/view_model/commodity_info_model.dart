import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/api/core/http_service.dart';
import 'package:qpp_example/api/item_api.dart';
import 'package:qpp_example/api/podo/core/base_response.dart';
import 'package:qpp_example/api/podo/item_select.dart';

class CommodityInfoModel extends ChangeNotifier {
  /// 物品資訊
  ApiResponse<ItemData> itemSelectInfoState = ApiResponse.initial();

  /// 頭像狀態
  ApiResponse<BaseResponse> avatarState = ApiResponse.initial();

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
    });
  }

  String get imgUrl {
    return '';
  }
}

// class ItemSelectStateNotifier extends StateNotifier<ApiResponse<ItemData>> {
//   ItemSelectStateNotifier() : super(ApiResponse.initial());

//   Future<void> request(String id) async {
//     state = ApiResponse.loading();

//     HttpService service = HttpService.instance;
//     Dio dio = service.dio;
//     final client = ItemApi(dio);
//     String requestBody = ItemSelectRequest().createItemSelectBody([id]);

//     client.postItemSelect(requestBody).then((itemSelectResponse) {
//       ItemData itemData = itemSelectResponse.getItem(0);
//       state = ApiResponse.completed(itemData);
//       print('Success');
//     }).catchError((error) {
//       state = ApiResponse.error(error);
//       print('get item data error: $error');
//     });
//   }
// }
