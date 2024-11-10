import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teachassist/main.dart';
import 'package:teachassist/radialgauge.dart';
import 'package:teachassist/scraper.dart';
import 'package:teachassist/tools/round.dart';

class OverviewPage extends StatelessWidget {
  double _calculateCourseAverage(List<Course> data) {
    int courseCount = 0;
    double courseTotal = 0;
    for (var course in data) {
      if (course.mark != -1) {
        courseCount++;
        courseTotal += course.mark;
      }
    }
    double courseAverage = (courseTotal / courseCount);
    return round(courseAverage, 1);
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: CourseWidget(course: course),
          )
      ],
    );
  }
}

class CourseWidget extends StatelessWidget {
  const CourseWidget({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Builder(builder: (context) {
            if (course.code.contains("LUNCH")) {
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
            } else {
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
                        ],
                      ),
                    ),
                    Builder(builder: (context) {
                      if (course.mark == -1) {
                        return Row(
                          children: [
                            const SizedBox(width: 4),
                            Container(
                              alignment: Alignment.centerRight,
                              height: 170,
                              width: 150,
                              child: Text(
                                "Please see teacher for current status regarding achievement in the course",
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container(
                            alignment: Alignment.centerRight,
                            height: 170,
                            width: 170,
                            child: RadialGauge(value: course.mark));
                      }
                    }),
                  ]);
            }
          }),
        ));
  }
}
