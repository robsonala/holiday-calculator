import 'package:flutter/material.dart';
import 'package:holiday2/ui/drawer.dart';

class HomePage extends StatelessWidget {
  static const String route = '/';

  final String title;
  final List<ListItem> items;

  HomePage({Key key, this.title, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        drawer: buildDrawer(context, route),
        body: ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: items.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = items[index];

            if (item is HeadingItem) {
              return ListTile(
                title: Text(
                  item.heading,
                  style: Theme.of(context).textTheme.headline,
                ),
              );
            } else if (item is MessageItem) {
              return ListTile(
                title: Text(item.title),
                subtitle: Text(item.dateFrom.toString() + ' - ' + item.dateTo.toString()),
              );
            }
          },
        ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
//            onPressed: counter.decrement,
            tooltip: 'Add',
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}

// The base class for the different types of items the list can contain.
abstract class ListItem {}

// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
}

// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String title;
  final DateTime dateFrom;
  final DateTime dateTo;

  MessageItem(this.title, this.dateFrom, this.dateTo);
}
