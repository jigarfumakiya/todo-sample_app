extension StringExtension on String {
  String toDocId() {
    var values = split("/");
    return values[values.length - 1];
  }

  DateTime fromTimeStampToDate() {
    final timeStamp = int.tryParse(this);
    return DateTime.fromMillisecondsSinceEpoch(timeStamp! * 1000);
  }
}
