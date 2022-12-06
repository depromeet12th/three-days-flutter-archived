import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:three_days/ui/statistics/day_of_week.dart';

class ThreeDaysCalendar extends StatefulWidget {
  final DateTime yearMonth;

  ThreeDaysCalendar({required this.yearMonth});

  @override
  State<StatefulWidget> createState() => _ThreeDaysCalendarState();
}

class _ThreeDaysCalendarState extends State<ThreeDaysCalendar> {
  late DateTime currentYearMonth;

  @override
  void initState() {
    super.initState();
    currentYearMonth = DateTime(
      widget.yearMonth.year,
      widget.yearMonth.month,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      currentYearMonth =
                          _getFirstDayOfPreviousMonth(currentYearMonth);
                    });
                  },
                  icon: Icon(Icons.keyboard_arrow_left),
                ),
                Text(_getFormattedYearMonth(currentYearMonth)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      currentYearMonth =
                          _getFirstDayOfNextMonth(currentYearMonth);
                    });
                  },
                  icon: Icon(Icons.keyboard_arrow_right),
                ),
              ],
            ),
            /// 요일 이름
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 7,
              crossAxisSpacing: 24,
              children: DayOfWeek.values
                  .map((e) => _getDayOfWeekNameWidget(e))
                  .toList(),
            ),
            Divider(
              height: 1,
            ),
            // 달력
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 7,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              children: _getItemsMonthly().map((e) => _getCalendarItemWidget(e)).toList(),
            ),
            Divider(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text('N월의 박수: A개'),
                  Spacer(),
                  Text('N월의 습관 실천일: B일'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DateTime _getFirstDayOfPreviousMonth(DateTime yearMonth) {
    final firstDayOfPreviousMonth = yearMonth.subtract(const Duration(days: 1));
    return DateTime(
      firstDayOfPreviousMonth.year,
      firstDayOfPreviousMonth.month,
    );
  }

  DateTime _getFirstDayOfNextMonth(DateTime yearMonth) {
    final someDayOfNextMonth = yearMonth.add(const Duration(days: 31));
    return DateTime(
      someDayOfNextMonth.year,
      someDayOfNextMonth.month,
    );
  }

  DateTime _getFirstDayOfThisMonth(DateTime dateTime) {
    return DateTime(
      dateTime.year,
      dateTime.month,
    );
  }

  DateTime _getLastDayOfThisMonth(DateTime dateTime) {
    final firstDayOfThisMonth = _getFirstDayOfThisMonth(dateTime);
    final firstDayOfNextMonth = _getFirstDayOfNextMonth(firstDayOfThisMonth);
    return firstDayOfNextMonth.subtract(const Duration(days: 1));
  }

  String _getFormattedYearMonth(DateTime yearMonth) {
    return DateFormat('yyyy년 MM월', 'ko').format(yearMonth);
  }

  Widget _getDayOfWeekNameWidget(DayOfWeek dayOfWeek) {
    return SizedBox(
      width: 24,
      height: 14,
      child: Text(
        dayOfWeek.getName(),
        style: TextStyle(
          color: dayOfWeek == DayOfWeek.sunday ? Colors.red : Colors.black,
          fontSize: 11,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  List<CalendarItem> _getItemsMonthly() {
    final firstDayOfThisMonth = _getFirstDayOfThisMonth(currentYearMonth);
    // prefix: firstDayOfThisMonth.weekday % 7
    final firstDay = firstDayOfThisMonth.day;
    final lastDayOfThisMonth = _getLastDayOfThisMonth(currentYearMonth);
    final lastDay = lastDayOfThisMonth.day;
    // content: firstDay ~ lastDay
    // suffix: 7 - lastDayOfThisMonth.weekday 개 만큼 뒤에 넣기

    final List<DateTime> days = [];

    // prefix
    var prefixCount = firstDayOfThisMonth.weekday % 7;
    while (prefixCount > 0) {
      days.add(firstDayOfThisMonth.subtract(Duration(days: prefixCount)));
      prefixCount -= 1;
    }
    // content
    var contentCount = 0;
    while (contentCount < lastDay) {
      days.add(firstDayOfThisMonth.add(Duration(days: contentCount)));
      contentCount += 1;
    }
    // suffix
    var suffixCount = (7 - (lastDayOfThisMonth.weekday + 1)) % 7;
    final numberOfSuffix = suffixCount;
    while (suffixCount-- > 0) {
      days.add(
          lastDayOfThisMonth.add(Duration(days: numberOfSuffix - suffixCount)));
    }
    return days.map((e) => CalendarItem(dateTime: e)).toList();
  }

  Widget _getCalendarItemWidget(CalendarItem calendarItem) {
    final valid = calendarItem.hasEqualYearMonth(currentYearMonth);
    if (!valid) {
      return Container();
    }
    return Center(child: Text(calendarItem.dateTime.day.toString()));
  }

}

class CalendarItem {
  final DateTime dateTime;

  CalendarItem({
    required this.dateTime,
  });

  bool hasEqualYearMonth(DateTime yearMonth) {
    return dateTime.year == yearMonth.year && dateTime.month == yearMonth.month;
  }
}
