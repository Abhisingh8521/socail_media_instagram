import 'package:intl/intl.dart';

extension DateExtensions on DateTime? {
  String get toDateOnly => DateFormat("dd/MM/yyyy").format(this!);

  String get toTimeOnly => DateFormat.jm().format(this!);

  String get fullDateAndTime => DateFormat("dd/MM/yyy HH:mm:ss").format(this!);

  String get toTimeWithSecond => DateFormat("HH:mm:ss a").format(this!);

  String get dateWithFullMonthName => DateFormat("dd MMMM yyyy").format(this!);

  String get dateWithHalfMonthName => DateFormat("dd MMM yyyy").format(this!);

  String get dayOnly => DateFormat("dd").format(this!);

  String get monthOnly => DateFormat("MM").format(this!);

  String get yearOnly => DateFormat("yyyy").format(this!);

  String get hourOnly => DateFormat("HH").format(this!);

  String get minutesOnly => DateFormat("mm").format(this!);

}
