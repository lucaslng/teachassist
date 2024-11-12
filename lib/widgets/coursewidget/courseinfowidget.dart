import 'package:flutter/material.dart';
import 'package:teachassist/utils/coursedata/course.dart';
import 'package:teachassist/widgets/coursewidget/courselevelwidget.dart';
import 'package:teachassist/widgets/coursewidget/courseradialwidget.dart';
import 'package:teachassist/widgets/coursewidget/courseseeteacherwidget.dart';

class CourseInfoWidget extends StatelessWidget {
  const CourseInfoWidget({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${course.code} - ${course.room}",
                  style: theme.textTheme.headlineSmall,
                ),
                if (course.name != "")
                  Text(
                    course.name,
                    style: theme.textTheme.bodyLarge,
                  ),
                Text(
                  "Period ${course.period}",
                  style: theme.textTheme.bodyLarge,
                ),
                if (course.hasFinal || course.hasMidterm)
                  Text(
                    '${course.hasFinal ? "Final" : "Midterm"} Mark: ${course.finalOrMidtermMark}%',
                    style: theme.textTheme.bodyLarge,
                  )
              ],
            ),
          ),
          LayoutBuilder(builder: (context, constraints) {
            if (course.status() == "upcoming") {
              return const SizedBox(width: 0);
            } else if (!course.hasMark) {
              return const SeeTeacherMessage();
            } else if (course.isLevel()) {
              return CourseLevelMessage(course: course);
            } else {
              return CourseMarkRadialGauge(course: course);
            }
          }),
        ]);
  }
}
