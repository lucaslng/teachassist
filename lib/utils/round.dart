import 'dart:math';

double round(double value, int places) {
  num mod = pow(10, places);
  return ((value * mod).round().toDouble() / mod);
}
