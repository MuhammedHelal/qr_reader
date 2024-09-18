import 'package:intl/intl.dart';

String formatDateTimeDate(String date) {
  final DateTime dateTime = DateTime.parse(date);
  final DateFormat formatter = DateFormat('M/d/yyyy');
  return formatter.format(dateTime);
}

String formatDateTimeTime(String date) {
  final DateTime dateTime = DateTime.parse(date);
  final DateFormat formatter = DateFormat('h:mm a');
  return formatter.format(dateTime);
}
