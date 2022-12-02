/// ***
/// This class consists of the DateWidget that is used in the ListView.builder
///
/// Author: Vivek Kaushik <me@vivekkasuhik.com>
/// github: https://github.com/iamvivekkaushik/
/// ***

import 'package:date_picker_timeline/gestures/tap.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum DateWidgetType { day, month, year }

class DateWidget extends StatelessWidget {
  final double? width;
  final DateTime date;
  final TextStyle? monthTextStyle, dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final DateSelectionCallback? onDateSelected;
  final String? locale;
  final DateWidgetType dateWidgetType;

  DateWidget({
    this.dateWidgetType = DateWidgetType.day,
    required this.date,
    required this.monthTextStyle,
    required this.dayTextStyle,
    required this.dateTextStyle,
    required this.selectionColor,
    this.width,
    this.onDateSelected,
    this.locale,
  });

  List<Widget> getDateCellView() {
    switch (dateWidgetType) {
      case DateWidgetType.day:
        return <Widget>[
          Text(
              new DateFormat("MMM", locale).format(date).toUpperCase(), // Month
              style: monthTextStyle),
          Text(date.day.toString(), // Date
              style: dateTextStyle),
          Text(
              new DateFormat("E", locale).format(date).toUpperCase(), // WeekDay
              style: dayTextStyle)
        ];
      case DateWidgetType.month:
        return <Widget>[
          Text(
              new DateFormat("yyyy", locale).format(date).toUpperCase(), // Year
              style: monthTextStyle),
          Text(date.month.toString(), // Date
              style: dateTextStyle),
          Text(
              new DateFormat("MMM", locale)
                  .format(date)
                  .toUpperCase(), // WeekDay
              style: dayTextStyle)
        ];
      case DateWidgetType.year:
        return <Widget>[
          Text(date.year.toString(), // Date
              style: dateTextStyle),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        margin: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: selectionColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: getDateCellView(),
          ),
        ),
      ),
      onTap: () {
        // Check if onDateSelected is not null
        if (onDateSelected != null) {
          // Call the onDateSelected Function
          onDateSelected!(this.date);
        }
      },
    );
  }
}
