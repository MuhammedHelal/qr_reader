import 'package:intl/intl.dart';

String formatDateTimeDate(String date) {
  final DateTime dateTime = DateTime.parse(date);
  final DateFormat formatter = DateFormat('d MMM yyyy');
  return formatter.format(dateTime);
}

String formatDateTimeTime(String date) {
  final DateTime dateTime = DateTime.parse(date);
  final DateFormat formatter = DateFormat('h:mm a');
  return formatter.format(dateTime);
}

String formatDateTime(String date) {
  final DateTime dateTime = DateTime.parse(date);
  final DateFormat formatter = DateFormat('d MMM yyyy, h:mm a');
  return formatter.format(dateTime);
}
