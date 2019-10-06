import 'package:flutter/material.dart';
import 'package:holiday2/pages/Create.dart';
import 'package:holiday2/pages/tabs/Tab.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      routes: <String, WidgetBuilder>{
        TabPage.route: (BuildContext context) => new TabPage(),
        CreatePage.route: (BuildContext context) => new CreatePage(),
      },
      initialRoute: TabPage.route,
      title: 'My Holidays',
      home: new TabPage(),
    );
  }
}