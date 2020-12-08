import 'package:flutter/material.dart';
import 'package:simply_responsive/src/layout_config.dart';

/// A widget which arranges its left, right, and center widget
/// based on provided [layoutConfig]. Center column will always have
/// fixed total width equals to [layoutConfig.screenWidth].
/// If exist, side columns will be arranged in a [Positioned] widget.
///
/// In the case of 2 column mode (left right) and no center, the page will not
/// use stack, just a Row with 2 child with their own widths
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

    List<Widget> stackChildren = [];

    if (_centerColumn != null) {
      stackChildren = [Positioned.fill(child: _centerColumn)];
      if (_leftColumn != null) {
        stackChildren.add(Positioned(
          left: layoutConfig.edgePadding,
          top: 0,
          bottom: 0,
          child: _leftColumn,
        ));
      }

      if (_rightColumn != null) {
        stackChildren.add(Positioned(
          top: 0,
          bottom: 0,
          right: layoutConfig.edgePadding,
          child: _rightColumn,
        ));
      }
      return Container(
        width: layoutConfig.screenWidth,
        child: Stack(children: stackChildren),
      );
    } else {
      // 2 columns mode
      if (_leftColumn != null) {
        stackChildren.add(_leftColumn);
      }
      if (_rightColumn != null) {
        stackChildren.add(_rightColumn);
      }

      return Container(
        width: layoutConfig.screenWidth,
        child: Row(children: stackChildren),
      );
    }
  }

  Widget _buildCenter(BuildContext context) {
    if (centerChild == null) {
      return null;
    }
    return Container(
      key: Key('centerColumn'),
      width: layoutConfig.screenWidth,
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
      width: layoutConfig.leftColumnWidth,
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
      width: layoutConfig.rightColumnWidth,
      child: rightChild,
    );
  }
}
