import 'package:flutter/material.dart';
import 'package:simply_responsive/src/layout_config.dart';

/// A widget which arranges its left, right, and center widget
/// based on provided [layoutConfig]. Center column will always have
/// fixed total width equals to [layoutConfig.screenWidth].
/// If exist, side columns will be arranged in a [Positioned] widget.
class SimplyResponsiveBody extends StatelessWidget {
  final LayoutConfig layoutConfig;
  final Widget leftChild;
  final Widget rightChild;
  final Widget centerChild;

  const SimplyResponsiveBody(
    this.layoutConfig, {
    this.leftChild,
    this.rightChild,
    this.centerChild,
  }) : assert(layoutConfig != null);

  @override
  Widget build(BuildContext context) {
    Widget _centerColumn = _buildCenter(context);
    Widget _leftColumn = _buildLeft(context);
    Widget _rightColumn = _buildRight(context);

    if (_centerColumn != null && _leftColumn == null && _rightColumn == null) {
      return _centerColumn;
    }

    return Container(
      width: layoutConfig.screenWidth.toDouble(),
      child: Stack(
        children: [
          Positioned.fill(child: _centerColumn),
          Positioned(
            left: layoutConfig.edgePadding.toDouble(),
            child: _leftColumn,
          ),
          Positioned(
            right: layoutConfig.edgePadding.toDouble(),
            child: _rightColumn,
          )
        ],
      ),
    );
  }

  Widget _buildCenter(BuildContext context) {
    return Container(
      key: Key('centerColumn'),
      width: layoutConfig.screenWidth.toDouble(),
      child: centerChild,
    );
  }

  Widget _buildLeft(BuildContext context) {
    if (layoutConfig.leftColumnWidth == 0 ||
        !layoutConfig.isLeftColumnVisible ||
        leftChild == null) {
      return null;
    }
    return Container(
      key: Key('leftColumn'),
      width: layoutConfig.leftColumnWidth.toDouble(),
      child: leftChild,
    );
  }

  Widget _buildRight(BuildContext context) {
    if (layoutConfig.rightColumnWidth == 0 ||
        !layoutConfig.isRightColumnVisible ||
        rightChild == null) {
      return null;
    }
    return Container(
      key: Key('rightColumn'),
      width: layoutConfig.rightColumnWidth.toDouble(),
      child: rightChild,
    );
  }
}
