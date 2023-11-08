import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_generator/easy_localization_generator.dart';
part 'qpp_locales.g.dart';

@SheetLocalization(
  // Google Sheet URL 上擷取的 ID
  docId: '1ZLwcuLfsAr3VNAfdj9jya5diioRryaxIpLB0zfrKw9k',
  // 代表多語系版本，每次更新 Google Sheet 後都可以更新此數字，接著 run build_runner 生成檔案
  version: 1,
  // 生成檔案的所在目錄
  outDir: 'assets/langs',
  // 生成檔案的名稱
  outName: 'langs.csv',
)

/// 多語系取用
// ignore: unused_element
class _QppLocales {}
