// Dart imports:
import 'dart:developer';
import 'dart:io';

// Flutter imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/gen/assets.gen.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:flutter_boilerplate/app/widget/app.dart';
import 'package:flutter_boilerplate/shared/http/http_override.dart';
import 'package:flutter_boilerplate/shared/util/logger.dart';

void start() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('de')],
      path: 'assets/translation',
      fallbackLocale: const Locale('en'),
      child: ProviderScope(
        observers: [Logger()],
        child: const App(),
      ),
    ),
  );
}
