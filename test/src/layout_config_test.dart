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
    expect(config.rightColumnWidth, 0);
    expect(config.screenWidth, 500);
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
      expect(config.rightColumnWidth, 0);
      expect(config.screenWidth, 750);
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
      expect(config.rightColumnWidth, 0);
      expect(config.screenWidth, 750);
    });
  });

  // group('should return desktop configuration', () {
  //   test('with both side columns', () {
  //     final config = LayoutConfig.build(1000);

  //     expect(config.centerLeftHorizontalPadding, 16);
  //     expect(config.centerRightHorizontalPadding, 16);
  //     expect(config.drawerWidth, 0.75 * 1000);
  //     expect(config.edgePadding, 16);
  //     expect(config.endDrawerWidth, 0.75 * 1000);
  //     expect(config.isLeftColumnVisible, true);
  //     expect(config.isRightColumnVisible, false);
  //     expect(config.leftColumnWidth, 250 - 16);
  //     expect(config.rightColumnWidth, 0);
  //     expect(config.screenWidth, 1000);
  //   });
  //   test('with left column', () {});
  //   test('with right column', () {});
  //   test('with center column only', () {});
  // });
}
