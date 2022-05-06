// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:flutter_boilerplate/app/widget/app.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(App());
    });
  });
}
