import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/api/local/api/local_api.dart';
import 'package:qpp_example/api/local/response/check_login_token.dart';
import 'package:qpp_example/api/local/response/get_login_token.dart';
import 'package:qpp_example/utils/shared_prefs.dart';

/// 驗證服務(登入/登出)Provider
final ChangeNotifierProvider<AuthServiceStateNotifier> authServiceProvider =
    ChangeNotifierProvider<AuthServiceStateNotifier>((ref) {
  // TODO: 不知道為啥放在這裡才會被初始化，main()那邊無效
  SharedPrefs.init();
  return AuthServiceStateNotifier();
});

/// 驗證服務(登入/登出)Notifier
class AuthServiceStateNotifier extends ChangeNotifier {
  /// 取得登入token狀態
  ApiResponse<GetLoginTokenResponse> getLoginTokenState = ApiResponse.initial();

  /// 驗證登入token狀態
  ApiResponse<CheckLoginTokenResponse> checkLoginTokenState =
      ApiResponse.initial();

  /// 登出狀態
  ApiResponse<()> logoutState = ApiResponse.initial();

  /// 計時器
  Timer? timer;

  /// 取得登入token
  void getLoginToken(String lang) {
    getLoginTokenState = ApiResponse.loading();
    notifyListeners();

    if (!(SharedPrefs.getLoginInfo()?.isLogin ?? false)) {
      final request = GetLoginTokenRequest().createBody(lang);

      LocalApi.client.postGetLoginToken(request).then((getLoginTokenResponse) {
        if (getLoginTokenResponse.isSuccess) {
          checkLoginToken(getLoginTokenResponse.data.vendorToken ?? "");
          getLoginTokenState = ApiResponse.completed(getLoginTokenResponse);
        } else {
          getLoginTokenState =
              ApiResponse.error(getLoginTokenResponse.errorInfo.errorMessage);
        }
        notifyListeners();
      }).catchError((error) {
        getLoginTokenState = ApiResponse.error(error);
        notifyListeners();
      });
    }
  }

  /// 驗證登入token
  void checkLoginToken(String vendorToken) {
    checkLoginTokenState = ApiResponse.loading();
    notifyListeners();

    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      final request = CheckLoginTokenRequest().createBody(vendorToken);

      LocalApi.client
          .postCheckLoginToken(request)
          .then((checkLoginTokenResponse) {
        getLoginTokenState = ApiResponse.initial();
        if (checkLoginTokenResponse.isSuccess) {
          timer.cancel();
          checkLoginTokenState = ApiResponse.completed(checkLoginTokenResponse);

          final loginInfoJS =
              "{\"uid\":\"${checkLoginTokenResponse.uid}\",\"vendorToken\":\"$vendorToken\",\"uidImage\":\"${checkLoginTokenResponse.uidImage}\"}";

          SharedPrefs.setLoginInfo(loginInfoJS);
        } else {
          checkLoginTokenState =
              ApiResponse.error(checkLoginTokenResponse.errorInfo.errorMessage);
        }
        notifyListeners();
      }).catchError((error) {
        print({'checkLoginToken error: $error'});
        checkLoginTokenState = ApiResponse.error(error);
        notifyListeners();
      });
    });
  }

  /// 取消Timer
  void cancelTimer() {
    timer?.cancel();
  }

  /// 登出
  void logout(String vendorToken) {
    logoutState = ApiResponse.loading();
    notifyListeners();

    LocalApi.client.getLogout(vendorToken).then((_) {
      checkLoginTokenState = ApiResponse.initial();
      SharedPrefs.removeLoginInfo();

      logoutState = ApiResponse.completed(());
      print(1231311);
      notifyListeners();
    }).catchError((error) {
      logoutState = ApiResponse.error(error);
      notifyListeners();
    });
  }
}
