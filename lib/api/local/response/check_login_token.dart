import 'dart:convert';
import 'package:qpp_example/api/local/response/base_local_response.dart';
import 'package:qpp_example/common_view_model/auth_service/model/login_info.dart';

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

  /// 登入者 id
  String get uid {
    if (content is Map<String, dynamic>) {
      return content['uid'] ?? "";
    }
    return "";
  }
  /// 投票用 token
  String get voteToken {
    if (content is Map<String, dynamic>) {
      return content['voteToken'] ?? "";
    }
    return "";
  }
  /// 登入者頭貼
  String get uidImage {
    if (content is Map<String, dynamic>) {
      return content['uidImage'] ?? "";
    }
    return "";
  }
}
