import 'package:flutter/material.dart';
import 'package:holiday2/pages/tabs/List.dart';
import 'package:holiday2/pages/tabs/Settings.dart';

class TabPage extends StatelessWidget {
  static const String route = '/tabs';

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('My Holidays'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.list)),
                Tab(icon: Icon(Icons.settings))
              ],
            )
          ),
          body: TabBarView(
            children: [
              ListTab(),
              SettingsTab(),
            ],
          ),
        ),
    );
  }
}