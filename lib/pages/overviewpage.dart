import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teachassist/main.dart';
import 'package:teachassist/utils/coursedata/course.dart';
import 'package:teachassist/utils/round.dart';
import 'package:teachassist/widgets/circlewidget.dart';
import 'package:teachassist/widgets/coursewidget/coursewidget.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:teachassist/widgets/custom_circular_progress_indicator.dart';

class OverviewPage extends StatelessWidget {
  final List<Course> data;
  const OverviewPage(this.data);


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
    var appState = context.watch<AppState>();
    var theme = Theme.of(context);

    double courseAverage = _calculateCourseAverage(data);

    return CustomMaterialIndicator(
      onRefresh: appState.refreshData,
      indicatorBuilder: (context, controller) {
        return const Padding(
          padding: EdgeInsets.all(4.0),
          child: CustomCircularProgressIndicator(),
        );
      },
      child: ListView(
        children: [
          const SizedBox(height: 10),
          Builder(
            builder: (context) {
              if (courseAverage != -1) {
                return Container(
                  height: 215,
                  width: 215,
                  child: Radial(
                    percent: courseAverage,
                    isBig: true,
                  )
                );
              } else {
                return const SizedBox(height: 0);
              }
            }
          ),
          const SizedBox(height: 10),
          for (var course in data)
            if (course.status() == "ongoing")
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: CourseWidget(course: course),
              ),
        ],
      ),
    );
  }
}
