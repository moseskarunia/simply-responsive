import 'package:example/string_content.dart';
import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:simply_responsive/simply_responsive.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simply Responsive Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Try to rotate your phone'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final config = LayoutConfig.build(MediaQuery.of(context).size.width);

    final _left = ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: leftContents.length + 1,
      itemBuilder: (context, i) {
        if (i == 0) {
          return Text(
            leftTitle,
            style: Theme.of(context).textTheme.headline5,
          );
        }
        return Text(
          leftContents[i - 1],
          style: Theme.of(context).textTheme.headline6,
        );
      },
      separatorBuilder: (_, __) => SizedBox(height: 16),
    );

    final _right = ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: leftContents.length + 1,
      itemBuilder: (context, i) {
        if (i == 0) {
          return Text(
            rightTitle,
            style: Theme.of(context).textTheme.headline5,
          );
        }
        return Text(
          rightContents[i - 1],
          style: Theme.of(context).textTheme.headline6,
        );
      },
      separatorBuilder: (_, __) => SizedBox(height: 16),
    );

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SimplyResponsiveBody(
        config,
        centerChild: ListView(
          padding: EdgeInsets.fromLTRB(
            config.centerLeftHorizontalPadding,
            16,
            config.centerRightHorizontalPadding,
            16,
          ),
          children: [
            Text(
              loremIpsum(initWithLorem: true, words: 500, paragraphs: 5),
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
        leftChild: _left,
        rightChild: _right,
      ),
      drawer: !config.hasLeftColumn
          ? Container(
              padding: const EdgeInsets.only(top: 32),
              color: Colors.white,
              width: config.drawerWidth,
              child: _left,
            )
          : null,
      endDrawer: !config.hasRightColumn
          ? Container(
              padding: const EdgeInsets.only(top: 32),
              color: Colors.white,
              width: config.drawerWidth,
              child: _right,
            )
          : null,
    );
  }
}
