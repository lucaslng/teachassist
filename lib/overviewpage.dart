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
          child: RadialGauge(value: _calculateCourseAverage(data))
        ),
        for (var course in data)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${course.name} - ${course.room}"),
                          Text(course.code),
                          Text(course.period),
                        ],
                      ),
                    ),
                    Container(
                      height: 180,
                      width: 180,
                      alignment: Alignment.centerRight,
                      child: Builder(
                        builder: (context) {
                          if (course.mark == -1) {
                            return const Text("Please see teacher for current status regarding achievement in the course");
                          } else {
                            return RadialGauge(value: course.mark);
                          }
                        }
                      ),
                    ),
                  ]
                ),
              )
            ),
          )
      ],
    );
  }
  
}
