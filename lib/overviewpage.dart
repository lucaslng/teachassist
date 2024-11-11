import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teachassist/course.dart';
import 'package:teachassist/coursewidget.dart';
import 'package:teachassist/main.dart';
import 'package:teachassist/radialgauge.dart';
import 'package:teachassist/tools/debug.dart';
import 'package:teachassist/tools/round.dart';

class OverviewPage extends StatelessWidget {
  double _calculateCourseAverage(List<Course> data) {
    int courseCount = 0;
    double courseTotal = 0;
    for (var course in data) {
      if (course.hasMark && !course.isLevel()) {
        courseCount++;
        courseTotal += course.getMark();
      }
    }
    if (courseCount > 0) {
      double courseAverage = (courseTotal / courseCount);
    // debug("$courseAverage - $courseTotal - $courseCount");
      return round(courseAverage, 1);
    } else {
      return -1;
    }
    
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var theme = Theme.of(context);

    List<Course> data = [];
    if (appState.data != null) {
      data = appState.data!;
    }

    return ListView(
      children: [
        const SizedBox(height: 10),
        Container(
            height: 300,
            width: 300,
            child: RadialGauge(
              value: _calculateCourseAverage(data),
              isAverage: true,
            )),
        for (var course in data)
          if (course.status() == "ongoing")
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: CourseWidget(course: course),
            ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Card(
            elevation: 3,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Completed Courses",
                  style: theme.textTheme.headlineMedium,
                ),
              ),
            )
          )
        ),
        for (var course in data)
          if (course.status() == "completed")
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: CourseWidget(course: course),
            ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Card(
            elevation: 3,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Upcoming Courses",
                  style: theme.textTheme.headlineMedium,
                ),
              ),
            )
          )
        ),
        for (var course in data)
          if (course.status() == "upcoming")
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: CourseWidget(course: course),
            ),
      ],
    );
  }
}
