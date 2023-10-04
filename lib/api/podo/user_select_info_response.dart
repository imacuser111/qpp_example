import 'package:qpp_example/api/core/base_api.dart';

/// 搜尋用戶資訊(單筆)
class UserSelectInfoRequest extends BaseApi {
  final int uid;

  UserSelectInfoRequest(this.uid);

  @override
  String get path => 'UserSelectInfo';

  @override
  RequestMethod get method => RequestMethod.post;

  @override
  Map<String, dynamic>? get body => <String, String>{
        'uid': uid.toString(),
      };
}

/// 搜尋用戶資訊(單筆)
class UserSelectInfoResponse {
  final String info;
  final String name;
  final int verificationType;

  const UserSelectInfoResponse({
    required this.info,
    required this.name,
    required this.verificationType,
  });

  factory UserSelectInfoResponse.fromJson(Map<String, dynamic> json) {
    return UserSelectInfoResponse(
      info: json['info'],
      name: json['name'],
      verificationType: json['verificationType'],
    );
  }
}