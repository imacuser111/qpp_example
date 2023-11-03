import 'package:flutter/widgets.dart';

/// 物品圖片資料, 存放物品圖片位址
class ItemImgData {
  // 圖片位址
  final String path;
  // NFT 背景顏色
  final String? colorHex;

  /// 一般物品建構式
  const ItemImgData(this.path) : colorHex = null;

  /// NFT 物品建構式
  const ItemImgData.NFT({required this.path, required this.colorHex});

  /// 取得 NFT 背景顏色, 未測試
  Color get bgColor {
    return Color(int.parse('0xFF$colorHex'));
  }
}
