import 'package:flutter/material.dart';
import 'package:teachassist/utils/coursedata/course.dart';
import 'package:teachassist/widgets/coursewidget/courseradialwidget.dart';

class CoursePage extends StatelessWidget {
  final Course course;
  const CoursePage(this.course);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              const SizedBox(height: 10),
              Text(
                course.code,
                style: theme.textTheme.headlineLarge,
              ),
              CourseMarkRadialGauge(course: course),
              const SizedBox(height: 10),
              for (var assignment in course.assignments)
                Text(
                  "${assignment.name} ${assignment.feedback == "" ? "" : ' - '} ${assignment.feedback}",
                  style: theme.textTheme.headlineMedium,
                )
            ]
          ),
        )
      )
    );
  }

}