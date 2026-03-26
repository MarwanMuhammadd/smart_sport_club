import 'package:intl/intl.dart';

String formatTime(DateTime time) {
  return DateFormat.jm().format(time);
}