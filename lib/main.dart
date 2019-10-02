import 'package:flutter/material.dart';
import 'package:holiday2/pages/Create.dart';
import 'package:holiday2/pages/Home.dart';
import 'package:holiday2/pages/Settings.dart';

void main() => runApp(MyApp(year: 2019));

class MyApp extends StatelessWidget {
  final appTitle = 'My Holidays';
  int year;

  MyApp({Key key, this.year}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        CreatePage.route: (context) => CreatePage(),
        SettingsPage.route: (context) => SettingsPage(),
      },
    );
  }
}