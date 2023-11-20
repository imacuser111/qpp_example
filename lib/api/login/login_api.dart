import 'package:qpp_example/api/core/http_service.dart';
import 'package:qpp_example/api/login/get_login_token.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'login_api.g.dart';

/// login 相關的 API
@RestApi(baseUrl: ServerConst.loginApiUrl)
abstract class LoginApi {
  @Deprecated('取得 client 請使用 LoginApi.client')
  factory LoginApi(Dio dio, {String baseUrl}) = _LoginApi;

  /// 取得 client
  static LoginApi get client {
    // ignore: deprecated_member_use_from_same_package
    return LoginApi(HttpService.instance.dio);
  }

  /// 取得登入 token
  @POST("GetLoginToken")
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<GetLoginTokenResponse> postGetLoginToken(@Body() lang);
}
