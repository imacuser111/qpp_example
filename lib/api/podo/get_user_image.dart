import 'package:intl/intl.dart';
import 'package:qpp_example/api/core/base_api.dart';
import 'package:qpp_example/utils/qpp_image_utils.dart';

/// 獲取用戶圖片時戳
class GetUserImageRequest extends BaseApi {
  final int uid;
  final QppImageStyle imageStyle;

  GetUserImageRequest(this.uid, this.imageStyle);

  @override
  String get path =>
      QppImageUtils.getUserImageFileName(uid, imageStyle: imageStyle);

  @override
  RequestMethod get method => RequestMethod.head;

  @override
  Map<String, dynamic>? get body => <String, String>{};

  @override
  Map<String, dynamic>? get query =>
      <String, String>{'v': DateTime.now().millisecondsSinceEpoch.toString()};
}

/// 獲取用戶圖片時戳
class GetUserImageResponse {
  /// 最後更新日期
  final List<String> lastModified;

  int get lastModifiedTimestamp {
    // 解析日期时间字符串
    DateFormat inputFormat = DateFormat('E dd MMM yyyy HH:mm:ss z', 'en_US');
    DateTime dateTime = inputFormat.parse(lastModified.join(''));

    int timestamp = dateTime.millisecondsSinceEpoch;
    return timestamp;
  }

  const GetUserImageResponse({
    required this.lastModified,
  });

  factory GetUserImageResponse.fromJson(Map<String, dynamic> json) {
    return GetUserImageResponse(
      lastModified: json['Last-Modified'],
    );
  }
}
