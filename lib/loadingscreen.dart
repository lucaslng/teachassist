import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      widthFactor: 100,
      heightFactor: 100,
      child: CircularProgressIndicator(
        strokeWidth: 10,
        strokeCap: StrokeCap.round,
      ),
    );
  }
}