import 'package:intl/intl.dart';

String formatDateTime(data) {
  var newFormat = DateFormat.yMMMEd();
  return newFormat.format(data);
}
