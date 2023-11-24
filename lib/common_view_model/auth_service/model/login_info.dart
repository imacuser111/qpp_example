import 'package:json_annotation/json_annotation.dart';

part 'login_info.g.dart';

/// 登入資訊
@JsonSerializable()
class LoginInfo {
  const LoginInfo({
    required this.expiredTimestamp,
    required this.refreshTokenTimestamp,
    required this.vendorToken,
    required this.uid,
    required this.uidImage,
  });

  /// 到期時戳
  final String? expiredTimestamp;

  /// 是否登入
  bool get isLogin => vendorToken.isNotEmpty;

  /// 刷新Token日期
  final DateTime? refreshTokenTimestamp;

  /// 廠商token
  final String vendorToken;

  /// 用戶id
  final String uid;

  /// 用戶圖片
  final String uidImage;

  factory LoginInfo.fromJson(Map<String, dynamic> json) =>
      _$LoginInfoFromJson(json);
}
