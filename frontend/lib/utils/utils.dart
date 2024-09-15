import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void debugLog(
  dynamic e, {
  StackTrace? stackTrace,
  String tag = 'DOWN_THE_AISLE',
}) {
  if (kDebugMode) {
    debugPrint('${tag.toUpperCase()} => $e');
    if (stackTrace != null) {
      debugPrintStack(stackTrace: stackTrace, label: '${tag.toUpperCase()} =>');
    }
  }
}

void postFrameCallback(VoidCallback callback) {
  WidgetsBinding.instance.addPostFrameCallback((_) => callback());
}
