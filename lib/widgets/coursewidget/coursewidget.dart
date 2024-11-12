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
    Widget content = Padding(
          padding: const EdgeInsets.all(12.0),
          child: Builder(builder: (context) {
            if (course.code.contains("LUNCH")) {
              return LunchWidget(course: course);
            } else {
              return CourseInfoWidget(course: course);
            }
          }),
    );

    if (course.hasMark) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: const ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12)))),
            padding: WidgetStatePropertyAll(EdgeInsets.all(4)),
          ),
          onPressed:() {
            Navigator.of(context).push((MaterialPageRoute(builder:(context) => CoursePage(course))));
          },
          child: content,
        ),
      );
    } else {
      return Card(
        elevation: 3,
        child: content,
      );
    }
  }
}
