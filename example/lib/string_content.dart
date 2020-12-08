final String leftTitle = 'This column will be placed on left column or drawer';
final List<String> leftContents = [
  'Try to scroll me.',
  '<<<<< Try to scroll the left edge of the screen, the center column will be scrolled instead (if this is not a drawer).',
  'The amount of edge space to scroll the center is determined by edgePadding in the LayoutConfig',
  'If you can see this column immediately, it means that your screen size is either tablet or desktop',
  'Otherwise it will be visible inside the drawer',
  'For now, the visibility of drawer is not automatic. But in future releases, it will be. So stay tuned. Feel free to submit a PR if you want to',
  'If you want to hide this column completely, try to set leftFlex in LayoutConfig.build to 0'
];

final String rightTitle =
    'This column will be placed on right column or endDrawer';
final List<String> rightContents = [
  'Try to scroll me.',
  '>>>>> Try to scroll the right edge of the screen, the center column will be scrolled instead (if this is not an endDrawer).',
  'The amount of edge space to scroll the center is determined by edgePadding in the LayoutConfig.',
  'If you can see this column immediately, it means that your screen size is either tablet or desktop',
  'Otherwise it will be visible inside the endDrawer',
  'For now, the visibility of drawer is not automatic. But in future releases, it will be. So stay tuned. Feel free to submit a PR if you want to',
  'If you want to hide this column completely, try to set right in LayoutConfig.build to 0'
];
