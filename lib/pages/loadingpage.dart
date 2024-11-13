import 'package:flutter/material.dart';
import 'package:teachassist/widgets/custom_circular_progress_indicator.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      widthFactor: 100,
      heightFactor: 100,
      child: CustomCircularProgressIndicator(),
    );
  }
}
