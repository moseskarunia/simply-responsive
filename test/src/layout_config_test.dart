import 'package:flutter_test/flutter_test.dart';
import 'package:simply_responsive/src/layout_config.dart';

void main() {
  test('should return mobile configuration', () {
    final config = LayoutConfig.build(500);

    expect(config.centerLeftHorizontalPadding, 16);
    expect(config.centerRightHorizontalPadding, 16);
    expect(config.drawerWidth, 0.75 * 500);
    expect(config.edgePadding, 16);
    expect(config.endDrawerWidth, 0.75 * 500);
    expect(config.isLeftColumnVisible, false);
    expect(config.isRightColumnVisible, false);
    expect(config.leftColumnWidth, 0);
    expect(config.maxVisibleActionButtons, 2);
    expect(config.rightColumnWidth, 0);
    expect(config.screenWidth, 500);
    expect(config.hasLeftColumn, false);
    expect(config.hasRightColumn, false);
  });

  group('should return tablet configuration', () {
    test('with left column', () {
      final config = LayoutConfig.build(750);

      final leftWidth = (1 * 750 / 3).floor();

      expect(config.centerLeftHorizontalPadding, leftWidth);
      expect(config.centerRightHorizontalPadding, 16);
      expect(config.drawerWidth, 0.5 * 750);
      expect(config.edgePadding, 16);
      expect(config.endDrawerWidth, 0.5 * 750);
      expect(config.isLeftColumnVisible, true);
      expect(config.isRightColumnVisible, false);
      expect(config.leftColumnWidth, leftWidth - 16);
      expect(config.maxVisibleActionButtons, 3);
      expect(config.rightColumnWidth, 0);
      expect(config.screenWidth, 750);
      expect(config.hasLeftColumn, true);
      expect(config.hasRightColumn, false);
    });
    test('with right column instead of left', () {
      final config = LayoutConfig.build(750, leftFlex: 0);

      final rightWidth = (1 * 750 / 3).floor();

      expect(config.centerLeftHorizontalPadding, 16);
      expect(config.centerRightHorizontalPadding, rightWidth);
      expect(config.drawerWidth, 0.5 * 750);
      expect(config.edgePadding, 16);
      expect(config.endDrawerWidth, 0.5 * 750);
      expect(config.isLeftColumnVisible, false);
      expect(config.isRightColumnVisible, true);
      expect(config.leftColumnWidth, 0);
      expect(config.rightColumnWidth, rightWidth - 16);
      expect(config.screenWidth, 750);
      expect(config.hasLeftColumn, false);
      expect(config.hasRightColumn, true);
    });
    test('with center column only', () {
      final config = LayoutConfig.build(750, leftFlex: 0, rightFlex: 0);

      expect(config.centerLeftHorizontalPadding, 93);
      expect(config.centerRightHorizontalPadding, 93);
      expect(config.drawerWidth, 0.5 * 750);
      expect(config.edgePadding, 93);
      expect(config.endDrawerWidth, 0.5 * 750);
      expect(config.isLeftColumnVisible, false);
      expect(config.isRightColumnVisible, false);
      expect(config.leftColumnWidth, 0);
      expect(config.maxVisibleActionButtons, 3);
      expect(config.rightColumnWidth, 0);
      expect(config.screenWidth, 750);
      expect(config.hasLeftColumn, false);
      expect(config.hasRightColumn, false);
    });

    test('with left and right column only', () {
      final config = LayoutConfig.build(
        750,
        leftFlex: 1,
        rightFlex: 1,
        centerFlex: 0,
      );

      expect(config.centerLeftHorizontalPadding, 375);
      expect(config.centerRightHorizontalPadding, 375);
      expect(config.drawerWidth, 0.5 * 750);
      expect(config.edgePadding, 0);
      expect(config.endDrawerWidth, 0.5 * 750);
      expect(config.isLeftColumnVisible, true);
      expect(config.isRightColumnVisible, true);
      expect(config.leftColumnWidth, 375);
      expect(config.maxVisibleActionButtons, 3);
      expect(config.rightColumnWidth, 375);
      expect(config.screenWidth, 750);
      expect(config.hasLeftColumn, true);
      expect(config.hasRightColumn, true);
    });
  });

  group('should return desktop configuration', () {
    test('with both side columns', () {
      final config = LayoutConfig.build(1000);

      expect(config.centerLeftHorizontalPadding, 250);
      expect(config.centerRightHorizontalPadding, 250);
      expect(config.drawerWidth, 0.25 * 1000);
      expect(config.edgePadding, 16);
      expect(config.endDrawerWidth, 0.25 * 1000);
      expect(config.isLeftColumnVisible, true);
      expect(config.isRightColumnVisible, true);
      expect(config.leftColumnWidth, 250 - 16);
      expect(config.maxVisibleActionButtons, 5);
      expect(config.rightColumnWidth, 250 - 16);
      expect(config.screenWidth, 1000);
      expect(config.hasLeftColumn, true);
      expect(config.hasRightColumn, true);
    });
    test('with left column', () {
      final config = LayoutConfig.build(1000, rightFlex: 0);
      final leftWidth = (1000 / 3).floor();

      expect(config.centerLeftHorizontalPadding, leftWidth);
      expect(config.centerRightHorizontalPadding, 16);
      expect(config.drawerWidth, 0.25 * 1000);
      expect(config.edgePadding, 16);
      expect(config.endDrawerWidth, 0.25 * 1000);
      expect(config.isLeftColumnVisible, true);
      expect(config.isRightColumnVisible, false);
      expect(config.leftColumnWidth, leftWidth - 16);
      expect(config.maxVisibleActionButtons, 5);
      expect(config.rightColumnWidth, 0);
      expect(config.screenWidth, 1000);
      expect(config.hasLeftColumn, true);
      expect(config.hasRightColumn, false);
    });
    test('with right column', () {
      final config = LayoutConfig.build(1000, leftFlex: 0);
      final rightWidth = (1000 / 3).floor();

      expect(config.centerLeftHorizontalPadding, 16);
      expect(config.centerRightHorizontalPadding, rightWidth);
      expect(config.drawerWidth, 0.25 * 1000);
      expect(config.edgePadding, 16);
      expect(config.endDrawerWidth, 0.25 * 1000);
      expect(config.isLeftColumnVisible, false);
      expect(config.isRightColumnVisible, true);
      expect(config.leftColumnWidth, 0);
      expect(config.maxVisibleActionButtons, 5);
      expect(config.rightColumnWidth, rightWidth - 16);
      expect(config.screenWidth, 1000);
      expect(config.hasLeftColumn, false);
      expect(config.hasRightColumn, true);
    });
    test('with center column only', () {
      final config = LayoutConfig.build(1000, leftFlex: 0, rightFlex: 0);
      final sidePadding = (1000 * 0.25 / 2).floor();

      expect(config.centerLeftHorizontalPadding, sidePadding);
      expect(config.centerRightHorizontalPadding, sidePadding);
      expect(config.drawerWidth, 0.25 * 1000);
      expect(config.edgePadding, sidePadding);
      expect(config.endDrawerWidth, 0.25 * 1000);
      expect(config.isLeftColumnVisible, false);
      expect(config.isRightColumnVisible, false);
      expect(config.leftColumnWidth, 0);
      expect(config.maxVisibleActionButtons, 5);
      expect(config.rightColumnWidth, 0);
      expect(config.screenWidth, 1000);
      expect(config.hasLeftColumn, false);
      expect(config.hasRightColumn, false);
    });

    test('with left and right column only', () {
      final config = LayoutConfig.build(
        1200,
        leftFlex: 2,
        rightFlex: 1,
        centerFlex: 0,
      );

      expect(config.centerLeftHorizontalPadding, 800);
      expect(config.centerRightHorizontalPadding, 400);
      expect(config.drawerWidth, 0.25 * 1200);
      expect(config.edgePadding, 0);
      expect(config.endDrawerWidth, 0.25 * 1200);
      expect(config.isLeftColumnVisible, true);
      expect(config.isRightColumnVisible, true);
      expect(config.leftColumnWidth, 800);
      expect(config.maxVisibleActionButtons, 5);
      expect(config.rightColumnWidth, 400);
      expect(config.screenWidth, 1200);
      expect(config.hasLeftColumn, true);
      expect(config.hasRightColumn, true);
    });
  });
}
