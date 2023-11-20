import 'package:retrofit/dio.dart';

/// 登出, 回應只有一個字串, 使用 HttpResponse
class LogoutResponse extends HttpResponse {
  LogoutResponse(super.data, super.response);
}
