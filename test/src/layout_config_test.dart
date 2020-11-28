import 'package:flutter_test/flutter_test.dart';
import 'package:simply_responsive/src/layout_config.dart';

void main() {
  test('should return mobile configuration', () {
    final config = LayoutConfig.build(500);

    expect(config.centerColumnWidth, 500);
    expect(config.centerLeftHorizontalPadding, 16);
    expect(config.centerRightHorizontalPadding, 16);
    expect(config.drawerWidth, 0.75 * 500);
    expect(config.edgePadding, 16);
    expect(config.endDrawerWidth, 0.75 * 500);
    expect(config.isLeftColumnVisible, false);
    expect(config.isRightColumnVisible, false);
    expect(config.leftColumnWidth, 0);
    expect(config.rightColumnWidth, 0);
    expect(config.screenWidth, 500);
  });

  group('should return tablet configuration', () {
    test('with left column', () {
      final config = LayoutConfig.build(750);

      final leftWidth = (1 * 750 / 3).floor();
      final centerWidth = 750 - leftWidth;

      expect(config.centerColumnWidth, centerWidth);
      expect(config.centerLeftHorizontalPadding, leftWidth);
      expect(config.centerRightHorizontalPadding, 16);
      expect(config.drawerWidth, 0.75 * 750);
      expect(config.edgePadding, 16);
      expect(config.endDrawerWidth, 0.75 * 750);
      expect(config.isLeftColumnVisible, true);
      expect(config.isRightColumnVisible, false);
      expect(config.leftColumnWidth, leftWidth - 16);
      expect(config.rightColumnWidth, 0);
      expect(config.screenWidth, 750);
    });
    test('with right column instead of left', () {
      final config = LayoutConfig.build(750, leftFlex: 0);

      final rightWidth = (1 * 750 / 3).floor();
      final centerWidth = 750 - rightWidth;

      expect(config.centerColumnWidth, centerWidth);
      expect(config.centerLeftHorizontalPadding, 16);
      expect(config.centerRightHorizontalPadding, rightWidth);
      expect(config.drawerWidth, 0.75 * 750);
      expect(config.edgePadding, 16);
      expect(config.endDrawerWidth, 0.75 * 750);
      expect(config.isLeftColumnVisible, false);
      expect(config.isRightColumnVisible, true);
      expect(config.leftColumnWidth, 0);
      expect(config.rightColumnWidth, rightWidth - 16);
      expect(config.screenWidth, 750);
    });
    test('with center column only', () {
      final config = LayoutConfig.build(750, leftFlex: 0, rightFlex: 0);

      expect(config.centerColumnWidth, 750);
      expect(config.centerLeftHorizontalPadding, 93);
      expect(config.centerRightHorizontalPadding, 93);
      expect(config.drawerWidth, 0.75 * 750);
      expect(config.edgePadding, 93);
      expect(config.endDrawerWidth, 0.75 * 750);
      expect(config.isLeftColumnVisible, false);
      expect(config.isRightColumnVisible, false);
      expect(config.leftColumnWidth, 0);
      expect(config.rightColumnWidth, 0);
      expect(config.screenWidth, 750);
    });
  });
}
