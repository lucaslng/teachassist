import 'package:flutter/material.dart';
import 'package:teachassist/utils/coursedata/course.dart';

class LunchWidget extends StatelessWidget {
  const LunchWidget({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
  }
}
