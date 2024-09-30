import 'dart:io';

import 'package:logger/logger.dart';

final logger = Logger(
  filter: Platform.environment['CORS_URL']?.contains('0.0.0.0') ?? false
      ? DevelopmentFilter()
      : ProductionFilter(),
);
