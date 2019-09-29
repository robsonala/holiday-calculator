import 'package:flutter/material.dart';
import 'package:holiday2/pages/Home.dart';

Drawer buildDrawer(BuildContext context, String currentRoute) {
  return Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          child: const Center(
            child: const Text('Menu'),
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),

        ListTile(
          title: const Text('Home'),
          selected: currentRoute == HomePage.route,
          onTap: () {
            Navigator.pushReplacementNamed(context, HomePage.route);
          },
        )
      ],
    ),
  );
}
