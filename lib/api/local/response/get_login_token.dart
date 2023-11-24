import 'dart:convert';
import 'package:qpp_example/api/local/response/base_local_response.dart';
import 'package:qpp_example/universal_link/universal_link_data.dart';

/// 取得登入 token
class GetLoginTokenRequest {
  String createBody(String lang) {
    return json.encode({'lang': lang});
  }
}

/// 取得登入 token
class GetLoginTokenResponse extends BaseLocalResponse {
  const GetLoginTokenResponse({required super.json});

  factory GetLoginTokenResponse.fromJson(Map<String, dynamic> json) {
    return GetLoginTokenResponse(
      json: json,
    );
  }

  UniversalLinkParamData get data =>
      UniversalLinkParamData.fromJson(Uri.parse(content).queryParameters);
}
