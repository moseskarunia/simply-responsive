# simply_responsive

![simply_responsive](https://github.com/moseskarunia/simply-responsive/workflows/simply_responsive/badge.svg)

A mobile-first widget to help us build a responsive app across mobile, tablet, and desktop with ease. Unlike the CSS 12 grid system, The design of simply_responsive is based on 3-columns design of a desktop website. This has an advantage of being simpler to use than the CSS 12 grid system, at the cost of reduced possible flexibilities. I try to make this library as tested as possible.

## Upcoming Timeline
- Simply Responsive Navigation Column
- Simply Responsive Right Column and App Bar

## Getting Started
There are 3 kind of screen sizes breakpoints with different configuration:
1. < 600px: Mobile Screen
  - Only center column
2. < 768px: Tablet Screen
  - All possible mobile screen configuration
  - Left and center column
  - Center and right column
  - Left and right column
3. >= 768px: Desktop
  - All possible tablet screen configuration
  - All 3 columns (left, center, right)

## How to Use

```dart
SimplyResponsiveBody(
  LayoutConfig.build(MediaQuery.of(context).size.width),
  leftChild: ListView(
    children: [
      Text('Home'),
      Text('Profile'),
      Text('Sign Out'),
    ]
  ),
  centerChild: ListView(
    children: [
      Text('Lorem Ipsum'),
      Text('Lorem ipsum dolor sit amet')
    ]
  ),
  rightChild: ListView(
    children: [
      Text('Tap to like')
      Text('Tap to dislike')
    ]
  )
)
```

Each `leftChild`, `centerChild`, and `rightChild` will always have finite width. 

For more info, you can read the dart doc I wrote directly in the library code.