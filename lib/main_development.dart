// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Project imports:
import 'package:flutter_boilerplate/start.dart';
import 'gen/assets.gen.dart';

void main() async {
  await dotenv.load(fileName: Assets.env.envProduction);
  start();
}
