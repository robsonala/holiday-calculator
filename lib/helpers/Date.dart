import 'package:intl/intl.dart';

class DateHelper {

  static String dateHourFormat(DateTime dateTime) => new DateFormat.yMd().add_jm().format(dateTime);
  static String dateFormat(DateTime dateTime) => new DateFormat.yMd().format(dateTime);

}