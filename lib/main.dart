import 'package:flutter/material.dart';
import 'package:flutter_examples/ExampleNameItem.dart';
import 'package:flutter_examples/models/ExapmleNames.dart';
import 'package:flutter_examples/ui/animatedicons/AnimatedIcons.dart';
import 'package:flutter_examples/ui/animatedsize/AnimatedSize.dart';
import 'package:flutter_examples/ui/app_bar/AppBarExample.dart';
import 'package:flutter_examples/ui/bottomnavigation/BottomNavigation.dart';
import 'package:flutter_examples/ui/collapsibletoolbar/CollapsibleToolbar.dart';
import 'package:flutter_examples/ui/drawer/NavigationDrawer.dart';
import 'package:flutter_examples/ui/hardwarekey/RawKeyboardDemo.dart';
import 'package:flutter_examples/ui/progressbutton/ProgressButton.dart';
import 'package:flutter_examples/ui/staggeredanimation/StaggerDemo.dart';
import 'package:flutter_examples/ui/stepper/StepperExample.dart';
import 'package:flutter_examples/ui/tabbar/TabBarExample.dart';
import 'package:flutter_examples/utils/Strings.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: Strings.appName,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: Strings.fontRobotoRegular,
        ),
        debugShowCheckedModeBanner: false,
        home: new MyHomePage(title: Strings.appName),
        routes: <String, WidgetBuilder>{
          Strings.appBarExampleRoute: (BuildContext context) => AppBarExample(),
          Strings.tabBarExampleRoute: (BuildContext context) => TabBarExample(
                title: Strings.TabBarTitle,
              ),
          Strings.navigationDrawerExampleRoute: (BuildContext context) =>
              NavigationDrawer(),
          Strings.bottomNavigationExampleRoute: (BuildContext context) =>
              BottomNavigation(title: Strings.bottomNavigationTitle),
          Strings.collapsibleToolbarExampleRoute: (BuildContext context) =>
              CollapsibleToolbar(title: Strings.appName),
          Strings.animatedIconsExampleRoute: (BuildContext context) =>
              AnimatedIconsDemo(title: Strings.animatedIconsTitle),
          Strings.animatedSizeExampleRoute: (BuildContext context) =>
              AnimatedSizeDemo(title: Strings.animatedSizeTitle),
          Strings.progressButtonExampleRoute: (BuildContext context) =>
              ProgressButton(title: Strings.progressButtonTitle),
          Strings.staggerDemoExampleRoute: (BuildContext context) =>
              StaggerDemo(title: Strings.staggerDemoTitle),
          Strings.stepperExampleRoute: (BuildContext context) =>
              StepperExample(title: Strings.stepperExampleTitle),
          Strings.hardwareKeyExampleRoute: (BuildContext context) =>
              RawKeyboardDemo(title: Strings.hardwareKeyExampleTitle),
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool status = false;

  bool get _status {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
          new IconButton(
            onPressed: () {
              _controller.fling(velocity: _status ? -2.0 : 2.0);
              setState(() {
                status = _status;
              });
            },
            icon: new AnimatedIcon(
              icon: AnimatedIcons.view_list,
              progress: _controller.view,
            ),
          ),
        ],
      ),
      body: new Column(
        children: <Widget>[
          Expanded(
            child: _buildExampleItemsWidget(_status),
          ),
        ],
      ),
    );
  }

  _buildExampleItemsWidget(bool status) {
    if (status) {
      return new ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
        new ExampleNameItem(
          exampleNames: names[index],
        ),
        itemCount: names.length,
      );
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3.0,
        ),
        itemBuilder: (BuildContext context, int index) =>
        new ExampleNameItem(
          exampleNames: names[index],
        ),
        itemCount: names.length,
      );
    }
  }
}

// The list displayed by this app.
final List<ExampleNames> names = <ExampleNames>[
  new ExampleNames(Strings.appBarTitle),
  new ExampleNames(Strings.TabBarTitle),
  new ExampleNames(Strings.navigationDrawerTitle),
  new ExampleNames(Strings.collapsibleToolbarTitle),
  new ExampleNames(Strings.bottomNavigationTitle),
  new ExampleNames(Strings.animatedIconsTitle),
  new ExampleNames(Strings.animatedSizeTitle),
  new ExampleNames(Strings.progressButtonTitle),
  new ExampleNames(Strings.staggerDemoTitle),
  new ExampleNames(Strings.stepperExampleTitle),
  new ExampleNames(Strings.hardwareKeyExampleTitle),
];
