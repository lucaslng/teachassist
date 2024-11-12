import 'package:flutter/material.dart';

class SeeTeacherMessage extends StatelessWidget {
  const SeeTeacherMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        const SizedBox(width: 4),
        Container(
          alignment: Alignment.centerRight,
          // height: 170,
          width: 150,
          child: Text(
            "Please see teacher for current status regarding achievement in the course",
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
