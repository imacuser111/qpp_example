import 'package:qpp_example/model/vote/vote_option_item.dart';

class VoteData {
  /// 題目
  late String voteTitle;

  /// 投票人數
  late int totalVoteNumber;

  /// 選項
  late List<VoteOptionItem> options = [];

  VoteData.create(Map<String, dynamic> json) {
    voteTitle = json['voteTitle'] ?? '';
    totalVoteNumber = json['totalVoteNumber'] ?? -1;
    for (var option in json['opreateItem']) {
      VoteOptionItem optionItem = VoteOptionItem(
          option: option['opreate'], voteCount: option['voteCount']);
      options.add(optionItem);
    }
  }
}
