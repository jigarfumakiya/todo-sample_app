import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_sample_app/core/app/app_colors.dart';
import 'package:todo_sample_app/core/extensions/date.dart';
import 'package:todo_sample_app/core/extensions/screen_utils.dart';

typedef OnDateChange = Function(DateTime date);

class DateWidget extends StatefulWidget {
  const DateWidget({
    Key? key,
    required this.onDateChange,
  }) : super(key: key);

  final OnDateChange onDateChange;

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => showDateDialog(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            selectedDate.toTodoDate(),
            style: textTheme.headline1!.copyWith(letterSpacing: 0),
          ),
          const SizedBox(width: 5),
          const Icon(
            Icons.keyboard_arrow_down_outlined,
            color: AppColors.blueColor,
          ),
        ],
      ),
    );
  }

  /// class methods
  Future<void> showDateDialog(BuildContext context) async {
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

    if (selectedDate != null) {
      widget.onDateChange.call(selectedDate);
      setState(() {});
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
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: selectedDate,
          headerStyle: const HeaderStyle(
              formatButtonShowsNext: false,
              formatButtonVisible: false,
              titleCentered: true,
              rightChevronIcon: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white,
              ),
              leftChevronIcon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          calendarStyle: CalendarStyle(
              isTodayHighlighted: false,
              defaultTextStyle:
                  textTheme.bodyText2!.copyWith(color: Colors.white),
              outsideDaysVisible: false,
              weekendTextStyle:
                  textTheme.bodyText2!.copyWith(color: Colors.white),
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
            // Delay so user do not see jump on screen
            Future.delayed(const Duration(milliseconds: 300), () {
              Navigator.of(context).pop(selectedDate);
            });
          },
        );
      }),
    );
  }
}