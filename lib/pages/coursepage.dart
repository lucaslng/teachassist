import 'package:flutter/material.dart';
import 'package:teachassist/utils/coursedata/course.dart';

class CoursePage extends StatelessWidget {
  final Course course;
  const CoursePage(this.course);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            const SizedBox(height: 10),
            Text(
              course.code,
              style: theme.textTheme.headlineLarge)
          ]
        )
      )
    );
  }

}