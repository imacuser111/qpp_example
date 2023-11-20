/// use for login api
class BaseLoginResponse {
  final Map<String, dynamic> json;

  /// 錯誤訊息
  LoginResponseErrorInfo get errorInfo {
    // errorInfo 可能回 null
    try {
      return LoginResponseErrorInfo(json: json['errorInfo']);
    } catch (exception) {
      return const LoginResponseErrorInfo.none();
    }
  }

  /// response 狀態
  int get status {
    return int.parse(json['status']);
  }

  /// response 內容
  String get content {
    try {
      return json['content'];
    } catch (exception) {
      return "";
    }
  }

  const BaseLoginResponse({required this.json});
}

/// LoginResponse 錯誤訊息
class LoginResponseErrorInfo {
  final Map<String, dynamic>? json;

  const LoginResponseErrorInfo({required this.json});
  const LoginResponseErrorInfo.none() : json = null;

  String get errorMessage {
    return json == null ? "" : json!['errorMessage'];
  }

  String get errorCode {
    return json == null ? "" : json!['errorCode'];
  }

  String get errorItem {
    return json == null ? "" : json!['errorItem'];
  }
}
