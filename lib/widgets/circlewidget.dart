import 'package:circle_chart/circle_chart.dart';
import 'package:flutter/material.dart';

class Radial extends StatelessWidget {
  final double percent;
  final bool isBig;
  const Radial({required this.percent, this.isBig = false, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percent = switch (this.percent) {
        0 => 0.01,
        100 => 99.9,
        // NaN
        final val when val.isNaN => 0.01,
        _ => this.percent,
    };
    final double size = isBig ? 300 : 170;
      
    return Stack(
      children: [
        CircleChart(
          maxNumber: 100,
          progressColor: theme.primaryColor,
          progressNumber: percent,
          width: size,
          height: size,
          animationDuration: const Duration(seconds: 1),
        )
      ]
    );
  }
  
}