import 'package:flutter/material.dart';
import 'package:teachassist/utils/coursedata/course.dart';
import 'package:teachassist/widgets/radialwidget.dart';

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