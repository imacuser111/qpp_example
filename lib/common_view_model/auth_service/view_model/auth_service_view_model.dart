import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/api/local/api/local_api.dart';
import 'package:qpp_example/api/local/response/check_login_token.dart';
import 'package:qpp_example/api/local/response/get_login_token.dart';

/// 驗證服務(登入/登出)Provider
final ChangeNotifierProvider<AuthServiceStateNotifier> authServiceProvider =
    ChangeNotifierProvider<AuthServiceStateNotifier>(
        (ref) => AuthServiceStateNotifier());

/// 驗證服務(登入/登出)Notifier
class AuthServiceStateNotifier extends ChangeNotifier {
  /// 取得登入token狀態
  ApiResponse<GetLoginTokenResponse> getLoginTokenState = ApiResponse.initial();

  /// 驗證登入token狀態
  ApiResponse<CheckLoginTokenResponse> checkLoginTokenState =
      ApiResponse.initial();

  /// 計時器
  Timer? timer;

  /// 取得登入token
  void getLoginToken(String lang) {
    getLoginTokenState = ApiResponse.loading();
    notifyListeners();

    final request = GetLoginTokenRequest().createBody(lang);

    LocalApi.client.postGetLoginToken(request).then((getLoginTokenResponse) {
      getLoginTokenState = ApiResponse.completed(getLoginTokenResponse);
      notifyListeners();
      if (getLoginTokenResponse.isSuccess) {
        checkLoginToken(getLoginTokenResponse.data.vendorToken ?? "");
      }
    }).catchError((error) {
      getLoginTokenState = ApiResponse.error(error);
      notifyListeners();
    });
  }

  /// 驗證登入token
  void checkLoginToken(String loginToken) {
    checkLoginTokenState = ApiResponse.initial();
    notifyListeners();

    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      final request = CheckLoginTokenRequest().createBody(loginToken);

      LocalApi.client
          .postCheckLoginToken(request)
          .then((checkLoginTokenResponse) {
        if (checkLoginTokenResponse.isSuccess) {
          timer.cancel();
          checkLoginTokenState = ApiResponse.completed(checkLoginTokenResponse);
          notifyListeners();
        }
      }).catchError((error) {
        checkLoginTokenState = ApiResponse.error(error);
        notifyListeners();
      });
    });
  }

  /// 取消Timer
  void cancelTimer() {
    timer?.cancel();
  }
}
