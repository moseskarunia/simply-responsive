import 'package:flutter/widgets.dart';
import 'package:simply_responsive/src/layout_config.dart';

/// Button which designated to be placed at the top right of simply responsive
/// scaffold's app bar. Will be used in later releases
abstract class SimplyResponsiveActionButton {
  /// Title of the button. If it's collapsed, will be set as tooltip's value
  final String title;

  /// Icon that will be used when this as a [PlainActionButton] is hidden
  /// in a "more" button (which when tapped will show a list of collapsed
  /// actions on an endDrawer), or when this as a [CollapsedMenuActionButton]
  /// is shown as a tabbed view.
  final Widget icon;

  const SimplyResponsiveActionButton({
    @required this.title,
    @required this.icon,
  });
}

/// Variant of a simply responsive action button, which is interactable.
/// When the amount of this is more that allowed (specified in [LayoutConfig]),
/// then it will be hidden in a more button, which when tapped, will list the
/// hidden [PlainActionButton] on an endDrawer.
class PlainActionButton extends SimplyResponsiveActionButton {
  final Widget button;

  const PlainActionButton({
    @required this.button,
    @required Widget icon,
    @required String title,
  }) : super(icon: icon, title: title);
}

/// If there are multiple [CollapsedMenuActionButton] in a
/// [SimplyResponsiveScaffold], and the right column is visible (not as a
/// endDrawer), then, child will be arranged in a tabbed view, and [icon]
/// will be used on the tabbar.
class CollapsedMenuActionButton extends SimplyResponsiveActionButton {
  /// Widget to be shown when the menu is expanded.
  final Widget child;

  const CollapsedMenuActionButton({
    @required this.child,
    @required Widget icon,
    @required String title,
  }) : super(icon: icon, title: title);
}
