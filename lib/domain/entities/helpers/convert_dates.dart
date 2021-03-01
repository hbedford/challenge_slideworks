import 'package:intl/intl.dart';

class ConvertDates {
  ConvertDates();
  stringBrToUniversalString(String date) {
    List<String> list = date.split('/');
    return list[2] + '/' + list[1] + '/' + list[0];
  }

  dateTimeToString(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
