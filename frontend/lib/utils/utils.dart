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

List<DateTime> get currentWeekDates {
  final now = DateTime.now();
  // Adjust to make Sunday 0 and Saturday 6
  final currentWeekDay = now.weekday % 7;
  final firstDayOfWeek = now.subtract(Duration(days: currentWeekDay));
  return List.generate(7, (index) => firstDayOfWeek.add(Duration(days: index)));
}
