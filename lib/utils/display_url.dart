import 'dart:html';

/// 顯示的網址
class DisplayUrl {
  /// 更新網址 params
  static updateParam(String key, String value) {
    // 先檢查是否有 query
    if (Uri.base.queryParameters.isNotEmpty) {
      // params 字串
      String params = Uri.base.toString().split('?')[1];
      // 有 query, 檢查是否有 lang parameter
      if (Uri.base.queryParameters.containsKey(key)) {
        // 有 lang parameter
        String lang = Uri.base.queryParameters[key].toString();
        int startIndex = params.indexOf(key);
        int endIndex = startIndex + 'lang'.length + lang.length + 1;
        params = params.replaceRange(startIndex, endIndex, 'lang=$value');
      } else {
        // 沒有 lang parameter
        params += '&lang=$value';
      }
      window.history.pushState({}, '', '${Uri.base.path}?$params');
    } else {
      // 沒有 query, 加上去
      window.history.pushState({}, '', '${Uri.base.path}?lang=$value');
    }
  }
}
