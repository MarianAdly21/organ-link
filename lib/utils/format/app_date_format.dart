import 'package:intl/intl.dart';

class AppDateFormat {
  static DateFormat appDateFormat(String local) {
    return DateFormat.yMMMMd(local);
  }

  static String formattingDate(DateTime date, String local) {
    try {
      return appDateFormat(local).format(date);
    } catch (e) {
      return "";
    }
  }

  static String tryFormattingDate(DateTime? date, String local) {
    try {
      return appDateFormat(local).format(date!);
    } catch (e) {
      return "";
    }
  }

  static String formattingTime(DateTime date, String local) {
    try {
      return DateFormat.jm(local).format(date);
    } catch (e) {
      return "";
    }
  }

  static String formattingDateTime(DateTime date, String local) {
    try {
      return appDateFormat(local).add_jm().format(date);
    } catch (e) {
      return "";
    }
  }

  static String dateFormatter(String date) {
    try {
      return DateFormat('dd MMM yyyy').format(DateTime.parse(date));
    } catch (e) {
      return "";
    }
  }

  static String dateFormatMMMDY(String date) {
    try {
      return DateFormat('MMM d, y').format(DateTime.parse(date));
    } catch (e) {
      return "";
    }
  }

  static String dateFormatMMMddyyyy(String date) {
    try {
      return DateFormat('MMM dd yyyy').format(DateTime.parse(date));
    } catch (e) {
      return "";
    }
  }
}
