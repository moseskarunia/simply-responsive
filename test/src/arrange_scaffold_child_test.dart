import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simply_responsive/src/arrange_scaffold_child.dart';
import 'package:simply_responsive/src/layout_config.dart';

void main() {
  final arrangeScaffoldChild = const ArrangeScaffoldChild();

  group('should return only list view in center column', () {
    testWidgets('when no leftChildren nor rightChildren', (tester) async {
      final configFixture = LayoutConfig.build(500);
      final widget = arrangeScaffoldChild(
        configFixture,
        centerChildren: <Widget>[
          Text('1'),
          Text('2'),
        ],
        centerSeparator: SizedBox(height: 16),
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      expect(widget, isA<ListView>());
      expect(find.byType(ListView), findsOneWidget);
      expect(
        find.ancestor(of: find.text('1'), matching: find.byType(ListView)),
        findsOneWidget,
      );
      expect(
        find.ancestor(of: find.text('2'), matching: find.byType(ListView)),
        findsOneWidget,
      );
      expect(
        tester.widget<ListView>(find.byType(ListView)).padding,
        EdgeInsets.fromLTRB(
          configFixture.centerLeftHorizontalPadding.toDouble(),
          16,
          configFixture.centerRightHorizontalPadding.toDouble(),
          0,
        ),
      );
      expect(
        find.descendant(
          of: find.byKey(Key('centerColumn')),
          matching: find.byWidgetPredicate(
            (w) => w is SizedBox && w.height == 16,
          ),
        ),
        findsNWidgets(1),
      );
      expect(find.byKey(Key('leftColumn')), findsNothing);
      expect(find.byKey(Key('rightColumn')), findsNothing);
    });
    testWidgets('when leftColumnWidth and rightColumnWidth equals 0',
        (tester) async {
      final configFixture = LayoutConfig.build(750, leftFlex: 0, rightFlex: 0);
      final widget = arrangeScaffoldChild(
        configFixture,
        centerChildren: <Widget>[Text('1'), Text('2')],
        leftChildren: <Widget>[Text('a'), Text('b')],
        rightChildren: <Widget>[Text('ax'), Text('bx')],
        centerSeparator: SizedBox(height: 16),
      );
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
      expect(widget, isA<ListView>());
      expect(find.byType(ListView), findsOneWidget);
      expect(
        find.ancestor(of: find.text('1'), matching: find.byType(ListView)),
        findsOneWidget,
      );
      expect(
        find.ancestor(of: find.text('2'), matching: find.byType(ListView)),
        findsOneWidget,
      );
      expect(
        tester.widget<ListView>(find.byType(ListView)).padding,
        EdgeInsets.fromLTRB(
          configFixture.centerLeftHorizontalPadding.toDouble(),
          16,
          configFixture.centerRightHorizontalPadding.toDouble(),
          0,
        ),
      );
      expect(
        find.descendant(
          of: find.byKey(Key('centerColumn')),
          matching: find.byWidgetPredicate(
            (w) => w is SizedBox && w.height == 16,
          ),
        ),
        findsNWidgets(1),
      );
      expect(find.byKey(Key('leftColumn')), findsNothing);
      expect(find.byKey(Key('rightColumn')), findsNothing);
    });
  });
}
