/// use for local api
class BaseLocalResponse {
  final Map<String, dynamic> json;

  /// 錯誤訊息
  LocalResponseErrorInfo get errorInfo {
    // errorInfo 可能回 null
    try {
      return LocalResponseErrorInfo(json: json['errorInfo']);
    } catch (exception) {
      return const LocalResponseErrorInfo.none();
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

  const BaseLocalResponse({required this.json});
}

/// LocalResponse 錯誤訊息
class LocalResponseErrorInfo {
  final Map<String, dynamic>? json;

  const LocalResponseErrorInfo({required this.json});
  const LocalResponseErrorInfo.none() : json = null;

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
