import 'package:flutter/material.dart';
import 'package:holiday2/models/ItemModel.dart';
import 'package:holiday2/pages/Create.dart';
import 'package:holiday2/providers/ItemProvider.dart';

abstract class ListHolidayItem {}

class HeadingItem implements ListHolidayItem {
  final String heading;

  HeadingItem(this.heading);
}

class MessageItem implements ListHolidayItem {
  final int id;
  final String title;
  final DateTime dateFrom;
  final DateTime dateTo;

  MessageItem(this.id, this.title, this.dateFrom, this.dateTo);
}

class ListTab extends StatelessWidget {
  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return HomeBody();
  }
}

class HomeBody extends StatefulWidget {
  @override
  HomeBodyState createState() => new HomeBodyState();
}

class HomeBodyState extends State<HomeBody> {
  List<ListHolidayItem> items = new List();
  var provider = new ItemProvider();

  @override
  void initState() {
    super.initState();
  }

  void loadItems() {
    provider.all().then((holidays) {
      setState(() {
        int lastYear;

        holidays.forEach((holiday) {
          var model = ItemModel.fromMap(holiday);
          var dF = DateTime.fromMillisecondsSinceEpoch(model.dateFrom);
          var dT = DateTime.fromMillisecondsSinceEpoch(model.dateTo);

          if (lastYear != dF.year) {
            lastYear = dF.year;
            items.add(HeadingItem(lastYear.toString()));
          }

          items.add(MessageItem(model.id, model.title, dF, dT));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: items.isEmpty
            ? Center(child: Text('No data found'))
            : ListView.builder(
                itemCount: items.length,
                padding: const EdgeInsets.all(15.0),
                itemBuilder: (context, position) {
                  final item = items[position];
                  ListTile listTile;

                  if (item is HeadingItem) {
                    return ListTile(
                      title: Text(
                        item.heading,
                        style: Theme.of(context).textTheme.headline,
                      ),
                    );
                  } else if (item is MessageItem) {
                    listTile = ListTile(
                      title: Text(item.title),
                      subtitle: Text(item.dateFrom.toString() +
                          ' - ' +
                          item.dateTo.toString()),
                    );

                    return Dismissible(
                        //key: Key(position.toString()),
                        key: Key(item.title + items.length.toString()),
                        onDismissed: (direction) {
                          setState(() {
                            provider.delete(item.id);
                            items.removeAt(position);
                          });

                          Scaffold.of(context).showSnackBar(SnackBar(
                              content:
                                  Text(item.title + " has been deleted!")));
                        },
                        background: Container(color: Colors.red),
                        child: listTile);
                  }
                }),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () async {
              await Navigator.of(context).pushNamed(CreatePage.route);

              this.loadItems();
            },
            tooltip: 'Add',
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
