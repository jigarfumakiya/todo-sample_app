import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String toTodoDate() {
    return DateFormat('MMM dd, yyyy').format(this);
  }

  String toTimeStamp() {
    final date = DateFormat('yyyy-MM-dd').parse(toIso8601String());
    return (date.toUtc().millisecondsSinceEpoch / 1000).toInt().toString();
  }
}
