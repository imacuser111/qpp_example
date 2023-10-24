import 'package:qpp_example/api/podo/get_user_image.dart';
import 'package:qpp_example/api/podo/item_select.dart';
import 'package:qpp_example/api/podo/user_select_info.dart';

class BaseResponse {
  final Map<String, dynamic> json;

  String get errorCode {
    return json['errorCode'];
  }

  const BaseResponse({required this.json});
}

extension BaseResponseExtension on BaseResponse {
  UserSelectInfoResponse get userSelectInfoResponse =>
      UserSelectInfoResponse.fromJson(json);

  GetUserImageResponse get getUserImageResponse =>
      GetUserImageResponse.fromJson(json);

  ItemSelectInfoResponse get itemSelectInfoResponse =>
      ItemSelectInfoResponse.fromJson(json);
}
