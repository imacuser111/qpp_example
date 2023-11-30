import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/client/api/client_api.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/api/client/response/user_select_info.dart';
import 'package:qpp_example/model/qpp_user.dart';
import 'package:qpp_example/utils/qpp_image_utils.dart';

/// 用戶資訊Provider
late ChangeNotifierProvider<UserInformationChangeNotifier>
    userInformationProvider;

/// 用戶資訊Notifier
class UserInformationChangeNotifier extends ChangeNotifier {
  /// 資訊狀態
  ApiResponse<QppUser> infoState = ApiResponse.initial();

  ApiResponse<int> userIDState = ApiResponse.initial();

  int userID = 0;

  /// 頭像圖片
  String avaterImage = "";

  /// 背景圖片
  String bgImage = "";

  /// 頭像錯誤
  bool avaterIsError = false;

  /// 背景圖錯誤
  bool bgImageIsError = false;

  /// 現在時間(撈取圖片使用)
  final nowTimestamp = DateTime.timestamp();

  /// 設定UserID
  void setUserID(int userID) {
    this.userID = userID;
    avaterImage = _getUserImage();
    bgImage = _getUserImage(style: QppImageStyle.backgroundImage);
    userIDState = ApiResponse.completed(userID);
    notifyListeners();
  }

  /// 取得用戶圖片
  String _getUserImage({QppImageStyle style = QppImageStyle.avatar}) {
    bool isAvater = style == QppImageStyle.avatar;

    return QppImageUtils.getUserImageURL(
      userID,
      imageStyle:
          isAvater ? QppImageStyle.avatar : QppImageStyle.backgroundImage,
      timestamp: nowTimestamp.millisecondsSinceEpoch,
    );
  }

  /// 取得用戶資訊
  void getUserInfo() {
    infoState = ApiResponse.loading();
    notifyListeners();

    final request = UserSelectInfoRequest().createBody(userID.toString());

    ClientApi.client.postUserSelect(request).then((userSelectInfoResponse) {
      infoState =
          ApiResponse.completed(QppUser.create(userID, userSelectInfoResponse));
      notifyListeners();
    }).catchError((error) {
      infoState = ApiResponse.error(error);
      notifyListeners();
    });
  }

  /// 設定圖片狀態
  void setImageState({
    QppImageStyle style = QppImageStyle.avatar,
    required bool isSuccess,
  }) {
    style == QppImageStyle.avatar
        ? avaterIsError = !isSuccess
        : bgImageIsError = !isSuccess;
    notifyListeners();
  }
}
