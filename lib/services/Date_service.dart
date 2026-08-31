import 'package:intl/intl.dart';

class DateService {
  static String getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }
}
