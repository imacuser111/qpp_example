import 'package:qpp_example/model/enum/item/vote_show_type.dart';
import 'package:qpp_example/model/enum/item/vote_type.dart';
import 'package:qpp_example/model/qpp_item.dart';
import 'package:qpp_example/model/vote/vote_data.dart';

/// 票券資料
class QppVote {
  final QppItem item;
  late VoteShowType voteShowType;

  /// 問券狀態
  late VoteType voteType;

  /// 題目及選項資料
  late List<VoteData> voteData = [];

  /// 過期日
  late String expiryDate;

  /// 自己的投票陣列
  late List<int> voteArrayData;

  QppVote.create(this.item, Map<String, dynamic> json) {
    voteShowType = VoteShowType.findTypeByValue(json['voteShowType'] ?? -1);
    voteType = VoteType.findTypeByValue(json['voteType'] ?? -1);
    expiryDate = json['expiryDate'] ?? '';
    for (var vote in json['voteData']) {
      VoteData vData = VoteData.create(vote);
      voteData.add(vData);
    }
    voteArrayData = json['voteArrayData'] ?? _setDefaultVoteArray();
  }
  // 沒投票資料, 都先塞 -1 進去
  _setDefaultVoteArray() {
    // voteArrayData = [];
    List<int> array = [];
    for (var i = 0; i < voteData.length; i++) {
      array.add(-1);
    }
    return array;
  }

  /// 設定答案
  /// 題目 [index], 選項 [index]
  setOption(int index, int option) {
    voteArrayData[index] = option;
  }

  /// 取得問券名稱
  String get itemName {
    return item.name;
  }
}
