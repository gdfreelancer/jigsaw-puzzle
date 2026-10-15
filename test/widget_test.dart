import 'package:flutter_test/flutter_test.dart';
import 'package:jigsaw_puzzle/main.dart';

void main() {
  testWidgets('Art Block Puzzle opens the splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const PuzzleApp());
    expect(find.text('ART BLOCK'), findsOneWidget);
    expect(find.text('LET’S PLAY'), findsOneWidget);
  });
}
