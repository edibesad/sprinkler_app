import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toFormattedString() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(this);
  }
}
