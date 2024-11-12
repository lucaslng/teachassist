import 'package:flutter/material.dart';
import 'package:teachassist/utils/coursedata/course.dart';

class CourseLevelMessage extends StatelessWidget {
  const CourseLevelMessage({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        const SizedBox(width: 4),
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            course.markString,
            style: theme.textTheme.headlineMedium,
          ),
        )
      ],
    );
  }
}
