import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_sample_app/core/extensions/screen_utils.dart';
import 'package:todo_sample_app/feature/todo/presentation/home/widget/date_widget.dart';

import '../app/app_colors.dart';

class AppDateDialog {
  final BuildContext context;

  DateTime selectedDate;
  final OnDateChange onDateChange;

  AppDateDialog({
    required this.context,
    required this.selectedDate,
    required this.onDateChange,
  });

  /// class methods
  /// Show the calendar dialog.
  Future<void> showDateDialog() async {
    final selectedDate = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _builtCalendar(context),
          ],
        ),
      ),
    );

    /// once user select any date
    /// send back date to parent widget
    if (selectedDate != null) {
      onDateChange.call(selectedDate);
    }
  }

  /// If calender widget use multiple place then move to there Own widget
  /// We can move calender widget to there own widget if we want more flexibility
  Widget _builtCalendar(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: (size.height * 0.33).toHeight,
      width: (size.width * 0.95).toWidth,
      child: StatefulBuilder(builder: (context, setState) {
        return TableCalendar(
          shouldFillViewport: true,
          dayHitTestBehavior: HitTestBehavior.translucent,
          availableGestures: AvailableGestures.horizontalSwipe,
          daysOfWeekHeight: 40,
          rowHeight: 55,
          firstDay: DateTime.now(),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: selectedDate,
          headerStyle: const HeaderStyle(
              formatButtonShowsNext: false,
              formatButtonVisible: false,
              titleCentered: true,
              rightChevronIcon: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black,
              ),
              leftChevronIcon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          calendarStyle: CalendarStyle(
              isTodayHighlighted: false,
              defaultTextStyle:
                  textTheme.bodyText2!.copyWith(color: Colors.black),
              outsideDaysVisible: false,
              weekendTextStyle:
                  textTheme.bodyText2!.copyWith(color: Colors.black),
              selectedDecoration: const BoxDecoration(
                color: AppColors.blueColor,
                shape: BoxShape.circle,
              ),
              todayDecoration: const BoxDecoration(
                color: AppColors.blueColor,
                shape: BoxShape.circle,
              )),
          daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: textTheme.subtitle1!.copyWith(
                  color: AppColors.independenceColor, letterSpacing: 0.03),
              weekendStyle: textTheme.subtitle1!.copyWith(
                  color: AppColors.independenceColor, letterSpacing: 0.03)),
          selectedDayPredicate: (day) {
            return isSameDay(selectedDate, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              selectedDate = selectedDay;
            });

            /// Delay so user do not see jump on screen
            /// So user can see which date they have select then pop
            Future.delayed(const Duration(milliseconds: 300), () {
              Navigator.of(context).pop(selectedDate);
            });
          },
        );
      }),
    );
  }
}
