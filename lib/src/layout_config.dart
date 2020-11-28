import 'dart:math';

import 'package:flutter/widgets.dart';

/// Build informations screen sizes.
/// This object is recalculated on each build call.
class LayoutConfig {
  final int screenWidth;

  /// Width of the left column.
  final int leftColumnWidth;

  /// Width of the drawer.
  final double drawerWidth;

  /// Width of the right column.
  final int rightColumnWidth;

  /// Width of the endDrawer.
  final double endDrawerWidth;

  /// When false, the left and right column won't be visible,
  /// no matter their respective widths.
  final bool isLeftColumnVisible, isRightColumnVisible;

  /// Edge padding to make the center scrollable from the edge of the screen.
  /// The same value will be substracted from both left and right column width
  /// (if any). Default value = 16.
  final int edgePadding;

  int get centerLeftHorizontalPadding => edgePadding + leftColumnWidth;
  int get centerRightHorizontalPadding => edgePadding + rightColumnWidth;

  const LayoutConfig({
    @required this.drawerWidth,
    this.edgePadding = 16,
    @required this.endDrawerWidth,
    @required this.isLeftColumnVisible,
    @required this.isRightColumnVisible,
    @required this.leftColumnWidth,
    @required this.rightColumnWidth,
    @required this.screenWidth,
  });

  /// Build layout config from [screenWidth]. The center will be calculated
  /// with ceiling rounding first.
  ///
  /// * [drawerToWidthRatio] ratio of drawer to the total width of the screen.
  ///   When null, the default value is: 0.75 on mobile, 0.5 on tablet, and
  ///   0.25 on desktop
  /// * [endDrawerRatio] ratio of drawer to the total width of the screen.
  ///   When null, the default value is: 0.75 on mobile, 0.5 on tablet, and
  ///   0.25 on desktop
  /// * [edgePadding] The space on the left and right of the screen to make
  ///   the center scrollable from the edge. The same amount will automatically
  ///   substracted from left and right width (if not already 0)
  /// * [leftFlex] will be ignored in mobile size.
  /// * [maxCenterToScreenRatioWhenNoSideColumn] Max center column width ratio
  ///   to screenWidth. Will be ignored unless left and right flex is 0. The
  ///   purpose of this property is to improve page readability by reducing
  ///   user's horizontal eye movement
  /// * [rightFlex] will be ignored in mobile size. Will be ignored in tablet
  ///   when [leftFlex] is not 0.

  factory LayoutConfig.build(
    int screenWidth, {
    int centerFlex = 2,
    double drawerToScreenWidthRatio,
    int edgePadding = 16,
    double endDrawerToScreenWidthRatio,
    int leftFlex = 1,
    int rightFlex = 1,
    double maxCenterToScreenRatioWhenNoSideColumn = 0.75,
  }) {
    double calculatedDrawerRatio, calculatedEndDrawerRatio;
    if (screenWidth < 600) {
      // Mobile
      calculatedDrawerRatio = drawerToScreenWidthRatio ?? 0.75;
      calculatedEndDrawerRatio = endDrawerToScreenWidthRatio ?? 0.75;
      return LayoutConfig(
        drawerWidth: calculatedDrawerRatio * screenWidth,
        endDrawerWidth: calculatedEndDrawerRatio * screenWidth,
        isLeftColumnVisible: false,
        isRightColumnVisible: false,
        leftColumnWidth: 0,
        rightColumnWidth: 0,
        screenWidth: screenWidth,
        edgePadding: edgePadding,
      );
    }

    if (screenWidth < 768) {
      calculatedDrawerRatio = drawerToScreenWidthRatio ?? 0.5;
      calculatedEndDrawerRatio = endDrawerToScreenWidthRatio ?? 0.5;
      // Tablet
      int totalFlex =
          leftFlex > 0 ? centerFlex + leftFlex : centerFlex + rightFlex;

      final leftWidth = max((leftFlex * screenWidth / totalFlex).floor(), 0);
      final rightWidth = leftFlex == 0
          ? max((rightFlex * screenWidth / totalFlex).floor(), 0)
          : 0;
      int centerWidth = screenWidth - (leftWidth + rightWidth);
      int calculatedEdgePadding = edgePadding;

      if (maxCenterToScreenRatioWhenNoSideColumn < 1 &&
          leftFlex == 0 &&
          rightFlex == 0) {
        calculatedEdgePadding =
            ((1.0 - maxCenterToScreenRatioWhenNoSideColumn) * screenWidth / 2)
                .floor();
      }

      return LayoutConfig(
        drawerWidth: calculatedDrawerRatio * screenWidth,
        endDrawerWidth: calculatedEndDrawerRatio * screenWidth,
        isLeftColumnVisible: leftFlex > 0,
        isRightColumnVisible: leftFlex == 0 && rightFlex > 0,
        leftColumnWidth: max(leftWidth - calculatedEdgePadding, 0),
        rightColumnWidth: max(rightWidth - calculatedEdgePadding, 0),
        screenWidth: screenWidth,
        edgePadding: calculatedEdgePadding,
      );
    }

    // Desktop or wider

    throw UnimplementedError();
  }
}
