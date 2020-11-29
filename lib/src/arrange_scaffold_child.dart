import 'package:flutter/widgets.dart';
import 'package:simply_responsive/src/layout_config.dart';

class ArrangeScaffoldChild {
  const ArrangeScaffoldChild();

  Widget call(
    LayoutConfig config, {
    @required List<Widget> centerChildren,
    @required Widget centerSeparator,
    List<Widget> leftChildren = const [],
    List<Widget> rightChildren = const [],
    int topListViewPadding = 16,
  }) {
    Widget centerChild = ListView.separated(
      key: Key('centerColumn'),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.fromLTRB(
        config.centerLeftHorizontalPadding.toDouble(),
        topListViewPadding.toDouble(),
        config.centerRightHorizontalPadding.toDouble(),
        0,
      ),
      separatorBuilder: (_, __) => centerSeparator,
      itemCount: centerChildren.length,
      itemBuilder: (context, i) => centerChildren[i],
    );

    if ((leftChildren.isEmpty && rightChildren.isEmpty) ||
        (config.leftColumnWidth == 0 && config.rightColumnWidth == 0)) {
      return centerChild;
    }

    throw UnimplementedError();
  }
}
