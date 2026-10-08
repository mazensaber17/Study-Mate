import 'package:flutter_test/flutter_test.dart';

import 'package:graduation_project/main.dart';

void main() {
  testWidgets('StudyMate app starts on the splash route', (tester) async {
    await tester.pumpWidget(const StudyMateApp());

    expect(find.text('StudyMate screen'), findsOneWidget);
  });
}
