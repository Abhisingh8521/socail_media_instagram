import 'package:flutter/material.dart';

class DateTimeBuilder {
  BuildContext context;

  DateTimeBuilder({required this.context});

  Future<DateTime?> showDatePickerView(
      {required DateTime firstDate, required DateTime lastDate}) {
    return showDatePicker(
        context: context, firstDate: firstDate, lastDate: lastDate);
  }

  Future<TimeOfDay?> showTimePickerView({required TimeOfDay initialTime}){
    return showTimePicker(context: context, initialTime: initialTime);
  }

}
