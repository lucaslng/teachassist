import 'package:flutter/material.dart';
import 'package:teachassist/course.dart';
import 'package:teachassist/radialgauge.dart';

class CourseWidget extends StatelessWidget {
  const CourseWidget({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Builder(builder: (context) {
            if (course.code.contains("LUNCH")) {
              return LunchWidget(course: course);
            } else {
              return CourseInfoWidget(course: course);
            }
          }),
        ));
  }
}

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

class LunchWidget extends StatelessWidget {
  const LunchWidget({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(children: [
      Text(
        "LUNCH",
        style: theme.textTheme.headlineSmall,
      ),
      Text(
        "Period ${course.period}",
        style: theme.textTheme.bodyLarge,
      ),
    ]);
  }
}

class CourseMarkRadialGauge extends StatelessWidget {
  const CourseMarkRadialGauge({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        height: 170,
        width: 170,
        child: RadialGauge(value: course.getMark()));
  }
}

class CourseLevelMessage extends StatelessWidget {
  const CourseLevelMessage({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        const SizedBox(width: 4),
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            course.markString,
            style: theme.textTheme.headlineMedium,
          ),
        )
      ],
    );
  }
}

class SeeTeacherMessage extends StatelessWidget {
  const SeeTeacherMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        const SizedBox(width: 4),
        Container(
          alignment: Alignment.centerRight,
          // height: 170,
          width: 150,
          child: Text(
            "Please see teacher for current status regarding achievement in the course",
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
