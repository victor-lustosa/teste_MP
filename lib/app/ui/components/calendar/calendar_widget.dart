import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../utils/date_util.dart';
import '../../view_models/data_view_model.dart';
import '../dialogs/clocks_list_dialog_mixin.dart';

class CalendarWidget extends StatefulWidget {
  final void Function(DateTime, DateTime)? action;
  const CalendarWidget({super.key, required this.action});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final DataViewModel viewModel = Modular.get<DataViewModel>();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  String userSelected = '';

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.cyan,
          shape: BoxShape.circle,
        ),
      ),
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: viewModel.focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        // Use `selectedDayPredicate` to determine which day is currently selected.
        // If this returns true, then `day` will be marked as selected.

        // Using `isSameDay` is recommended to disregard
        // the time-part of compared DateTime objects.
        return isSameDay(viewModel.selectedDay, day);
      },
      onDaySelected:  widget.action,
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          // Call `setState()` when updating calendar format
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        viewModel.focusedDay = focusedDay;
      },
    );
  }
}
