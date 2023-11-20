import 'dart:convert';
import 'package:qpp_example/api/local/response/base_local_response.dart';

/// 認證登入 token
class CheckLoginTokenRequest {
  String createBody(String token) {
    return json.encode({'token': token});
  }
}

/// 認證登入 token
class CheckLoginTokenResponse extends BaseLocalResponse {
  const CheckLoginTokenResponse({required super.json});

  factory CheckLoginTokenResponse.fromJson(Map<String, dynamic> json) {
    return CheckLoginTokenResponse(
      json: json,
    );
  }
}
