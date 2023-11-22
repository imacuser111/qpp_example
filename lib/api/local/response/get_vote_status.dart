import 'dart:convert';
import 'package:qpp_example/api/local/response/base_local_response.dart';

/// 取得投票狀態
class GetVoteStatusRequest {
  String createBody(String itemId, String voteToken) {
    return json.encode({'ItemId': itemId, 'VoteToken': voteToken});
  }
}

/// 取得投票狀態
class GetVoteStatusResponse extends BaseLocalResponse {
  const GetVoteStatusResponse({required super.json});

  factory GetVoteStatusResponse.fromJson(Map<String, dynamic> json) {
    return GetVoteStatusResponse(
      json: json,
    );
  }
}
