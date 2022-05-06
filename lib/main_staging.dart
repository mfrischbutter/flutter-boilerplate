// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Project imports:
import 'package:flutter_boilerplate/gen/assets.gen.dart';
import 'package:flutter_boilerplate/start.dart';

void main() async {
  await dotenv.load(fileName: Assets.env.envStaging);
  start();
}
