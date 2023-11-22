/// 登入資訊
class LoginInfo {
  const LoginInfo(
      {required this.expiredTimestamp,
      required this.isLogin,
      required this.refreshTokenTimestamp,
      required this.token,
      required this.uid});

  /// 到期時戳
  final int expiredTimestamp;

  /// 是否登入
  final bool isLogin;

  /// 刷新Token日期
  final DateTime refreshTokenTimestamp;

  /// token
  final String token;

  /// 用戶id
  final int uid;
}
