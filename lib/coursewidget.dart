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
    final theme = Theme.of(context);
    return Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
                        if (course.status() != "upcoming") {
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
                          return const SizedBox(width: 0);
                        }
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
