extension ListExtensions<T> on List<T> {
  List<T> get filterLast {
    return isEmpty ? <T>[] : sublist(0, length - 1);
  }
}
