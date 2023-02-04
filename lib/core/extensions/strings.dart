extension StringExtension on String {
  String toDocId() {
    var values = split("/");
    return values[values.length - 1];
  }
}
