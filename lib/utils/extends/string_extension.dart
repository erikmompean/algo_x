extension IntExtension on int {
  double toAlgorand() {
    return this / 100000;
  }

  String toAlgorandString() {
    return (this / 1000000).toStringAsFixed(2);
  }
}