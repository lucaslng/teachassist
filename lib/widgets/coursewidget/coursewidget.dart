import 'package:flutter/material.dart';
import 'package:teachassist/pages/coursepage.dart';
import 'package:teachassist/utils/coursedata/course.dart';
import 'package:teachassist/widgets/coursewidget/courseinfowidget.dart';
import 'package:teachassist/widgets/coursewidget/lunchwidget.dart';

class CourseWidget extends StatelessWidget {
  const CourseWidget({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: const ButtonStyle(shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))))),
        onPressed:() {
          Navigator.of(context).push((MaterialPageRoute(builder:(context) => CoursePage(course))));
        },
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
