// Dart imports:
import 'dart:developer';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:flutter_boilerplate/app/widget/app.dart';
import 'package:flutter_boilerplate/shared/http/http_override.dart';
import 'package:flutter_boilerplate/shared/util/logger.dart';
import 'package:flutter_boilerplate/shared/util/platform_type.dart';

void start() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final platformType = detectPlatformType();

  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  runApp(ProviderScope(
    overrides: [
      platformTypeProvider.overrideWithValue(platformType),
    ],
    observers: [Logger()],
    child: App(),
  ));
}
