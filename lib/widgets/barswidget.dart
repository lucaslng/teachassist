import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      swapAnimationDuration: Durations.medium4,
      swapAnimationCurve: Curves.easeOutCubic,
      BarChartData(

      ),
    );
  }
  
}