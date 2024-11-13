import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class Radial extends StatelessWidget {
  final double percent;
  final bool isBig;
  const Radial({required this.percent, this.isBig = false, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double thickness = isBig ? (215*0.12) : (170*0.12);

    return Stack(
      alignment: const Alignment(0, 0.3),
      children: [
        Text(
          percent.toString(),
          style: isBig ? theme.textTheme.displayLarge : theme.textTheme.displayMedium),
        AnimatedRadialGauge(
          // alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutCubic,
          radius: 270,
          value: percent,
          axis: GaugeAxis(
            min: 0,
            max: 100,
            degrees: 270,
            style: GaugeAxisStyle(
              thickness: thickness,
              background: theme.colorScheme.surfaceContainerHigh,
              cornerRadius: const Radius.circular(20),
            ),
            pointer: null,
            progressBar: GaugeProgressBar.rounded(
              color: theme.colorScheme.primary,
              gradient: GaugeAxisGradient(colors: [theme.colorScheme.primary, theme.colorScheme.primaryFixedDim])
            ),
          ),
        ),
      ],
    );

    // return Stack(
    //   children: [
    //     CircleChart(
    //       maxNumber: 100,
    //       progressColor: theme.primaryColor,
    //       progressNumber: percent,
    //       width: size,
    //       height: size,
    //       animationDuration: const Duration(seconds: 1),
    //     )
    //   ]
    // );
  }
}
