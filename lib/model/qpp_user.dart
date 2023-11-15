import 'package:qpp_example/api/podo/user_select_info.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/model/enum/user/user_verification_type.dart';

class QppUser {
  final int id;
  late String name;
  late String info;
  late VerificationType verificationType;

  QppUser.create(this.id, UserSelectInfoResponse response) {
    name = response.name;
    info = response.info;
    verificationType =
        VerificationType.findTypeByValue(response.verificationType);
  }

  /// 是否為官方帳號
  bool get isOfficial => verificationType.isOfficial;

  /// 取得暱稱
  String get displayName => name.isEmpty ? QppLocales.errorPageNickname : name;

  /// 取得簡介
  String get displayInfo => info.isEmpty ? QppLocales.errorPageInfoNotyet : info;

  /// 取得官方帳號 icon path
  String get officialIconPath =>
      isOfficial ? 'desktop-icon-newsfeed-official-large.svg' : '';

  /// 取得 ID
  String get displayID => id.toString();
}
