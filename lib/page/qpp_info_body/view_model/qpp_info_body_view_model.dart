import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/api/podo/core/base_response.dart';
import 'package:qpp_example/api/podo/get_user_image.dart';
import 'package:qpp_example/api/podo/user_select_info.dart';
import 'package:qpp_example/utils/qpp_image_utils.dart';

class UserSelectInfoChangeNotifier extends ChangeNotifier {
  /// 資訊狀態
  ApiResponse<BaseResponse> infoState = ApiResponse.initial();

  /// 頭像狀態
  ApiResponse<BaseResponse> avaterState = ApiResponse.initial();

  /// 背景圖片狀態
  ApiResponse<BaseResponse> bgImageState = ApiResponse.initial();

  /// 頭像錯誤
  bool avaterIsError = false;

  /// 背景圖錯誤
  bool bgImageIsError = false;

  /// 取得用戶資訊
  getUserInfo(int userID) {
    infoState = ApiResponse.loading();
    notifyListeners();

    final request = UserSelectInfoRequest(userID);

    request.request(successCallBack: (data) {
      infoState = ApiResponse.completed(data);
      notifyListeners();
    }, errorCallBack: (error) {
      infoState = ApiResponse.error(error);
      notifyListeners();
    });
  }

  /// 取得用戶圖片
  getUserImage(int userID, {QppImageStyle style = QppImageStyle.avatar}) {
    bool isAvater = style == QppImageStyle.avatar;

    isAvater
        ? avaterState = ApiResponse.loading()
        : bgImageState = ApiResponse.loading();

    final request = GetUserImageRequest(userID, style);

    request.request(successCallBack: (data) {
      isAvater
          ? avaterState = ApiResponse.completed(data)
          : bgImageState = ApiResponse.completed(data);
    }, errorCallBack: (error) {
      isAvater
          ? avaterState = ApiResponse.error(error)
          : bgImageState = ApiResponse.error(error);
    });
  }

  /// 圖片錯誤(翻轉)
  imageErrorToggle({QppImageStyle style = QppImageStyle.avatar}) {
    style == QppImageStyle.avatar
        ? avaterIsError = !avaterIsError
        : bgImageIsError = !bgImageIsError;
    notifyListeners();
  }
}
