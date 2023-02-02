import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String toTodoDate() {
    return DateFormat('MMM dd, yyyy').format(this);
  }
}
