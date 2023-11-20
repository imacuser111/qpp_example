import 'dart:convert';
import 'package:qpp_example/api/login/base_login_response.dart';

/// 取得登入 token
class GetLoginTokenRequest {
  String createBody(String lang) {
    return json.encode({'lang': lang});
  }
}

/// 取得登入 token
class GetLoginTokenResponse extends BaseLoginResponse {
  const GetLoginTokenResponse({required super.json});

  factory GetLoginTokenResponse.fromJson(Map<String, dynamic> json) {
    return GetLoginTokenResponse(
      json: json,
    );
  }
}
