import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateTimePickerController extends GetxController {
  var datePicker = TextEditingController();
  DateTime? selectedDate;

  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Theme.of(context).primaryColor,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (dateTime != null) {
      selectedDate = dateTime;
      controller.text = DateFormat('yyyy-MM-dd').format(dateTime);
    }
  }
}
