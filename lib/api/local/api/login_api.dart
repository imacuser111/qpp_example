import 'package:qpp_example/api/core/http_service.dart';
import 'package:qpp_example/api/local/response/check_login_token.dart';
import 'package:qpp_example/api/local/response/get_login_token.dart';
import 'package:qpp_example/api/local/response/get_vote_info.dart';
import 'package:qpp_example/api/local/response/get_vote_status.dart';
import 'package:qpp_example/api/local/response/logout.dart';
import 'package:qpp_example/api/local/response/user_vote.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'login_api.g.dart';

/// 票券 相關的 API, 登入, 投票...
@RestApi(baseUrl: ServerConst.localApiUrl)
abstract class LocalApi {
  @Deprecated('取得 client 請使用 LoginApi.client')
  factory LocalApi(Dio dio, {String baseUrl}) = _LocalApi;

  /// 取得 client
  static LocalApi get client {
    // ignore: deprecated_member_use_from_same_package
    return LocalApi(HttpService.instance.dio);
  }

  /// 取得登入 token
  @POST("login/GetLoginToken")
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<GetLoginTokenResponse> postGetLoginToken(@Body() lang);

  /// 確認是否登入, 成功 取得投票 token (loop 詢問)
  @POST("login/CheckLoginToken")
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<CheckLoginTokenResponse> postCheckLoginToken(@Body() data);

  /// 取得投票狀態
  @POST("vote/GetVoteStatus")
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<GetVoteStatusResponse> postGetVoteStatus(@Body() data);

  /// 登出
  @GET('login/LogOut?token={token}')
  Future<HttpResponse> getLogout(@Path('token') String token);

  /// 取得投票狀態
  @POST("vote/GetVoteInfo")
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<GetVoteInfoResponse> postGetVoteInfo(@Body() data);

  /// 送出投票
  @POST("vote/UserVote")
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<UserVoteResponse> postUserVote(@Body() data);
}
