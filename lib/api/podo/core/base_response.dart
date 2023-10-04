import 'package:qpp_example/api/podo/user_select_info_response.dart';

class BaseResponse {
  final Map<String, dynamic> json;

  String get errorCode {
    return json['errorCode'];
  }

  const BaseResponse({required this.json});
}

extension BaseResponseExtension on BaseResponse {
  UserSelectInfoResponse get userSelectInfoResponse {
    return UserSelectInfoResponse.fromJson(json);
  }
}