import 'dart:convert';
import 'package:qpp_example/api/client/base_client_response.dart';

/// 搜尋用戶資訊(單筆)
class UserSelectInfoRequest {
  String createBody(String uid) {
    return json.encode({'uid': uid});
  }
}

/// 搜尋用戶資訊(單筆)
class UserSelectInfoResponse extends BaseClientResponse {
  final String info;
  final String name;
  final int verificationType;

  const UserSelectInfoResponse({
    required this.info,
    required this.name,
    required this.verificationType,
    required super.json,
  });

  factory UserSelectInfoResponse.fromJson(Map<String, dynamic> json) {
    return UserSelectInfoResponse(
      info: json['info'],
      name: json['name'],
      verificationType: json['verificationType'],
      json: json,
    );
  }
}
