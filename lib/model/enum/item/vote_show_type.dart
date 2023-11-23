
enum VoteShowType {
  error(-1),
  noShow(1),
  show(2),
  questionMark(3);

  final int value;

  const VoteShowType(this.value);

  static VoteShowType findTypeByValue(int value) {
    return switch (value) {
      1 => VoteShowType.noShow,
      2 => VoteShowType.show,
      3 => VoteShowType.questionMark,
      _ => VoteShowType.error,
    };
  }
}
