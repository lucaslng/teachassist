import 'package:flutter/foundation.dart';

void debug(Object? object) {
  if (kDebugMode) {
    debugPrint("DEBUG: ${object.toString()}");
  }
}
