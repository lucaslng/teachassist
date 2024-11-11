import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialGauge extends StatelessWidget {
  const RadialGauge({
    super.key,
    required this.value,
    this.isAverage = false,
  });

  final double value;
  final bool isAverage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SfRadialGauge(
      enableLoadingAnimation: true,
      animationDuration: 1000,
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
            maximum: 100,
            showLabels: false,
            showTicks: false,
            pointers: [
              RangePointer(
                value: value,
                cornerStyle: CornerStyle.bothCurve,
                color: theme.colorScheme.primary,
                width: 0.2,
                sizeUnit: GaugeSizeUnit.factor,
              ),
            ],
            axisLineStyle: AxisLineStyle(
              thickness: 0.2,
              cornerStyle: CornerStyle.bothCurve,
              color: theme.colorScheme.surfaceContainerHigh,
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                positionFactor: 0.1,
                angle: 90,
                widget: Text(
                  value.toString(),
                  style: isAverage
                      ? theme.textTheme.displayLarge
                      : theme.textTheme.displayMedium,
                )
              )
            ]
        )
      ],
    );
  }
}
