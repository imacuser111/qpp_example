import 'dart:core';

/// 邀請碼工具
class InvitationUtils {
  InvitationUtils._internal();
  static final InvitationUtils instance = InvitationUtils._internal();

  /// userId 轉換成邀請碼
  static String userIdToInvitationCode(String userId) {
    if (userId.length <= 9) {
      return "";
    }

    List<int> swaps = [1, 6, 2, 9, 3, 5, 4, 8];
    List<int> ids = userId.runes.toList();

    for (int i = 0; i < swaps.length - 1; i += 2) {
      int tmp = ids[ids.length - swaps[i + 1]];
      ids[ids.length - swaps[i + 1]] = ids[ids.length - swaps[i]];
      ids[ids.length - swaps[i]] = tmp;
    }

    int length = (userId.length + 2) ~/ 3;
    String convertingStr = String.fromCharCodes(ids);

    // 查码表为0~9，A~Z，去除易混淆数量IOZ，共33个字
    List<String> characters = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'J',
      'K',
      'L',
      'M',
      'N',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y'
    ];

    StringBuffer builder = StringBuffer();
    for (int i = 0; i < convertingStr.length; i += 3) {
      int encode = int.parse(convertingStr.substring(i, i + 3));
      builder.write(characters[encode ~/ characters.length]);
      builder.write(characters[encode % characters.length]);
    }
    return builder.toString();
  }

  // SU00CE2R

  /// code 轉換成 user id, test OK
  static String invitationCodeToUserId(String code) {
    if (code.isEmpty || code.length % 2 != 0 || code.length <= 6) {
      return "";
    }
    // 反解
    StringBuffer builder = StringBuffer();
    // 查码表为0~9，A~Z，去除易混淆数量IOZ，共33个字
    String encodes = "0123456789ABCDEFGHJKLMNPQRSTUVWXY";
    for (int i = 0; i < code.length; i += 2) {
      String c1 = code.substring(i, i + 1);
      String c2 = code.substring(i + 1, i + 2);

      if (!encodes.contains(c1) || !encodes.contains(c2)) {
        return "";
      }

      int decode = encodes.indexOf(c1) * encodes.length + encodes.indexOf(c2);
      builder.write(decode.toString().padLeft(3, '0'));
    }

    // 交换索引
    List<int> swaps = [1, 6, 2, 9, 3, 5, 4, 8];
    var length = builder.length;
    // 位移交换
    for (int i = 0; i < swaps.length; i += 2) {
      var tmp = builder.toString()[length - swaps[i + 1]];

      builder = StringBuffer(builder.toString().replaceRange(
          length - swaps[i + 1],
          (length - swaps[i + 1]) + 1,
          builder.toString()[length - swaps[i]]));

      builder = StringBuffer(builder
          .toString()
          .replaceRange(length - swaps[i], (length - swaps[i]) + 1, tmp));
    }

    return builder.toString();
  }

  static String replaceCharAtIndex(String original, int index, String newChar) {
    if (index < 0 || index >= original.length) {
      // 确保索引有效
      return original;
    }

    // 将字符串拆分为前缀和后缀
    String prefix = original.substring(0, index);
    String suffix = original.substring(index + 1);

    // 构建新字符串
    String replacedString = '$prefix$newChar$suffix';

    return replacedString;
  }

  static String getCharAtIndex(String original, int index) {
    if (index >= 0 && index < original.length) {
      String character = original[index];
      return character;
    }
    throw Exception('Invalid character');
  }
}
