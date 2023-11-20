import 'dart:convert';
import 'package:qpp_example/api/local/response/base_local_response.dart';

/// 取得投票物品資料
class GetVoteInfoRequest {
  String createBody(String itemId) {
    return json.encode({'ItemId': itemId});
  }
}

/// 取得投票狀態
class GetVoteInfoResponse extends BaseLocalResponse {
  const GetVoteInfoResponse({required super.json});

  factory GetVoteInfoResponse.fromJson(Map<String, dynamic> json) {
    return GetVoteInfoResponse(
      json: json,
    );
  }
}
