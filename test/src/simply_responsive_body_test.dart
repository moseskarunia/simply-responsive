import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simply_responsive/src/layout_config.dart';
import 'package:simply_responsive/src/simply_responsive_body.dart';

void main() {
  group('should return with all three columns:', () {
    final config = LayoutConfig.build(1000);
    SimplyResponsiveBody body;
    setUp(() {
      /// Otherwise defaults to 800x600
      WidgetsBinding.instance.renderView.configuration =
          new TestViewConfiguration(size: const Size(1024, 768));

      body = SimplyResponsiveBody(
        config,
        centerChild: Text('the center'),
        leftChild: Text('the left'),
        rightChild: Text('the right'),
      );
    });

    testWidgets('center column is correct', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: body)));

      final centerWidget = find.byKey(Key('centerColumn'));
      expect(tester.getSize(centerWidget).width, config.screenWidth);
      expect(
        find.ancestor(of: find.text('the center'), matching: centerWidget),
        findsOneWidget,
      );

      final centerPositioned = find.ancestor(
        of: centerWidget,
        matching: find.byType(Positioned),
      );
      expect(centerPositioned, findsOneWidget);
    });

    testWidgets('left column is correct', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: body)));

      final leftWidget = find.byKey(Key('leftColumn'));
      expect(tester.getSize(leftWidget).width, config.leftColumnWidth);

      final leftPositioned = find.ancestor(
        of: leftWidget,
        matching: find.byType(Positioned),
      );
      expect(leftPositioned, findsOneWidget);
      expect(
        tester.widget<Positioned>(leftPositioned).left,
        config.edgePadding,
      );
      expect(
        find.ancestor(
          of: leftPositioned,
          matching: find.byType(Stack),
        ),
        findsOneWidget,
      );
    });

    testWidgets('right column is correct', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: body)));

      final rightWidget = find.byKey(Key('rightColumn'));
      expect(tester.getSize(rightWidget).width, config.rightColumnWidth);

      final rightPositioned = find.ancestor(
        of: find.text('the right'),
        matching: find.byType(Positioned),
      );
      expect(rightPositioned, findsOneWidget);
      expect(
        tester.widget<Positioned>(rightPositioned).right,
        config.edgePadding,
      );
      expect(
        find.ancestor(
          of: rightPositioned,
          matching: find.byType(Stack),
        ),
        findsOneWidget,
      );
    });

    testWidgets('outer container', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: body)));

      final rightWidget = find.byType(Stack);
      final outerContainer = find.ancestor(
        of: rightWidget,
        matching: find.byType(Container),
      );

      expect(tester.getSize(outerContainer).width, config.screenWidth);
    });
  });

  group('should return only the center column', () {
    void performAssertion(WidgetTester tester, LayoutConfig config) {
      final centerWidget = find.byKey(Key('centerColumn'));
      final leftWidget = find.byKey(Key('leftColumn'));
      final rightWidget = find.byKey(Key('rightColumn'));

      expect(centerWidget, findsOneWidget);
      expect(leftWidget, findsNothing);
      expect(rightWidget, findsNothing);

      expect(tester.getSize(centerWidget).width, config.screenWidth);

      /// When only center column, the direct ancestor should be a scaffold
      expect(
        find.ancestor(of: centerWidget, matching: find.byType(Scaffold)),
        findsOneWidget,
      );
    }

    testWidgets('if both !hasLeftColumn & !hasRightColumn', (tester) async {
      final config = LayoutConfig(
        screenWidth: 500,
        leftColumnWidth: 0,
        rightColumnWidth: 0,
        isLeftColumnVisible: true,
        isRightColumnVisible: true,
      );
      final body = SimplyResponsiveBody(
        config,
        centerChild: Text('the center'),
        leftChild: Text('the left'),
        rightChild: Text('the right'),
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: body)));

      performAssertion(tester, config);
    });

    testWidgets('if left & right child is null', (tester) async {
      final config = LayoutConfig(
        screenWidth: 500,
        leftColumnWidth: 100,
        rightColumnWidth: 100,
        isLeftColumnVisible: true,
        isRightColumnVisible: true,
      );
      final body = SimplyResponsiveBody(
        config,
        centerChild: Text('the center'),
        leftChild: null,
        rightChild: null,
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: body)));

      performAssertion(tester, config);
    });
  });

  group('should return left and center only', () {
    void performAssertion(WidgetTester tester, LayoutConfig config) {
      final centerWidget = find.byKey(Key('centerColumn'));
      final leftWidget = find.byKey(Key('leftColumn'));
      final rightWidget = find.byKey(Key('rightColumn'));
      expect(centerWidget, findsOneWidget);
      expect(leftWidget, findsOneWidget);
      expect(rightWidget, findsNothing);

      expect(tester.getSize(centerWidget).width, config.screenWidth);
      expect(tester.getSize(leftWidget).width, config.leftColumnWidth);

      final leftPositioned = find.ancestor(
        of: leftWidget,
        matching: find.byType(Positioned),
      );
      expect(leftPositioned, findsOneWidget);
      expect(
        tester.widget<Positioned>(leftPositioned).left,
        config.edgePadding,
      );
      expect(
        find.ancestor(of: leftPositioned, matching: find.byType(Stack)),
        findsOneWidget,
      );
      final centerPositioned = find.ancestor(
        of: centerWidget,
        matching: find.byType(Positioned),
      );
      expect(centerPositioned, findsOneWidget);
      expect(find.byType(Positioned), findsNWidgets(2));

      expect(
        find.ancestor(of: leftPositioned, matching: find.byType(Stack)),
        findsOneWidget,
      );
      expect(
        find.ancestor(of: centerPositioned, matching: find.byType(Stack)),
        findsOneWidget,
      );
    }

    testWidgets('if hasLeftColumn && !hasRightColumn', (tester) async {
      final config = LayoutConfig(
        screenWidth: 500,
        leftColumnWidth: 100,
        rightColumnWidth: 0,
        isLeftColumnVisible: true,
        isRightColumnVisible: false,
        edgePadding: 16,
      );

      final body = SimplyResponsiveBody(
        config,
        centerChild: Text('the center'),
        leftChild: Text('the left'),
        rightChild: Text('the right'),
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: body)));
      performAssertion(tester, config);
    });

    testWidgets('if hasLeftColumn && no rightChild', (tester) async {
      final config = LayoutConfig(
        screenWidth: 500,
        leftColumnWidth: 100,
        rightColumnWidth: 100,
        isLeftColumnVisible: true,
        isRightColumnVisible: true,
        edgePadding: 16,
      );

      final body = SimplyResponsiveBody(
        config,
        centerChild: Text('the center'),
        leftChild: Text('the left'),
        rightChild: null,
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: body)));
      performAssertion(tester, config);
    });
  });

  group('should return right and center only', () {
    void performAssertion(WidgetTester tester, LayoutConfig config) {
      final centerWidget = find.byKey(Key('centerColumn'));
      final leftWidget = find.byKey(Key('leftColumn'));
      final rightWidget = find.byKey(Key('rightColumn'));
      expect(centerWidget, findsOneWidget);
      expect(leftWidget, findsNothing);
      expect(rightWidget, findsOneWidget);

      expect(tester.getSize(centerWidget).width, config.screenWidth);
      expect(tester.getSize(rightWidget).width, config.rightColumnWidth);

      final rightPositioned = find.ancestor(
        of: rightWidget,
        matching: find.byType(Positioned),
      );
      expect(rightPositioned, findsOneWidget);
      expect(
        tester.widget<Positioned>(rightPositioned).right,
        config.edgePadding,
      );
      expect(
        find.ancestor(of: rightPositioned, matching: find.byType(Stack)),
        findsOneWidget,
      );
      final centerPositioned = find.ancestor(
        of: centerWidget,
        matching: find.byType(Positioned),
      );
      expect(centerPositioned, findsOneWidget);
      expect(find.byType(Positioned), findsNWidgets(2));

      expect(
        find.ancestor(of: rightPositioned, matching: find.byType(Stack)),
        findsOneWidget,
      );
      expect(
        find.ancestor(of: centerPositioned, matching: find.byType(Stack)),
        findsOneWidget,
      );
    }

    testWidgets('if hasRightColumn && !hasLeftColumn', (tester) async {
      final config = LayoutConfig(
        screenWidth: 500,
        leftColumnWidth: 0,
        rightColumnWidth: 100,
        isLeftColumnVisible: false,
        isRightColumnVisible: true,
        edgePadding: 16,
      );

      final body = SimplyResponsiveBody(
        config,
        centerChild: Text('the center'),
        leftChild: Text('the left'),
        rightChild: Text('the right'),
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: body)));
      performAssertion(tester, config);
    });

    testWidgets('if hasRightColumn && no leftChild', (tester) async {
      final config = LayoutConfig(
        screenWidth: 500,
        leftColumnWidth: 100,
        rightColumnWidth: 100,
        isLeftColumnVisible: true,
        isRightColumnVisible: true,
        edgePadding: 16,
      );

      final body = SimplyResponsiveBody(
        config,
        centerChild: Text('the center'),
        leftChild: null,
        rightChild: Text('the right'),
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: body)));
      performAssertion(tester, config);
    });
  });

  testWidgets('should build 2 columns mode', (tester) async {
    final config = LayoutConfig(
      screenWidth: 500,
      leftColumnWidth: 300,
      rightColumnWidth: 200,
      isLeftColumnVisible: true,
      isRightColumnVisible: true,
      edgePadding: 16,
    );

    final body = SimplyResponsiveBody(
      config,
      centerChild: null,
      leftChild: Text('the left'),
      rightChild: Text('the right'),
    );
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: body)));

    final centerWidget = find.byKey(Key('centerColumn'));
    final leftWidget = find.byKey(Key('leftColumn'));
    final rightWidget = find.byKey(Key('rightColumn'));
    expect(centerWidget, findsNothing);
    expect(leftWidget, findsOneWidget);
    expect(rightWidget, findsOneWidget);

    expect(tester.getSize(leftWidget).width, config.leftColumnWidth);
    expect(tester.getSize(rightWidget).width, config.rightColumnWidth);

    final row1 = find.ancestor(of: leftWidget, matching: find.byType(Row));
    final row2 = find.ancestor(of: rightWidget, matching: find.byType(Row));
    expect(row1, findsOneWidget);
    expect(row2, findsOneWidget);

    expect(tester.widget<Row>(row1).children.length, 2);

    final outerContainer =
        find.ancestor(of: row1, matching: find.byType(Container));

    expect(tester.getSize(outerContainer).width, config.screenWidth);
  });
}
