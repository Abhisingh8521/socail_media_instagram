import 'package:fluttertoast/fluttertoast.dart';

extension StringExtensions on String? {
  /// validators
  String? defaultFieldValidator() => this!.isEmpty ? "This field is required" : null;

  static var emailReg = RegExp(
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

  String? emailFieldValidator() =>
      (emailReg.hasMatch(this!) ? null : "Please enter valid email");

  String? phoneFieldValidator() =>
      (this!.length <= 9 ? "Please enter a valid number" : null);
  static var pinRegExp = RegExp("[1-9][0-9]{5}");

  String? pinCodeFieldValidator() =>
      (pinRegExp.hasMatch(this!)) ? "Please enter a valid pin code" : null;

  double toDouble() => double.parse(this!);
  int toInt()=> int.parse(this!);
  Uri toUri()=> Uri.parse(this!);

  Future<bool?> showToast()=> Fluttertoast.showToast(msg: this!);
}
