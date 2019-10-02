import 'package:flutter/material.dart';
import 'package:holiday2/models/ItemModel.dart';
import 'package:holiday2/pages/Create.dart';
import 'package:holiday2/providers/ItemProvider.dart';
import 'package:holiday2/ui/drawer.dart';

abstract class ListHolidayItem {}

class HeadingItem implements ListHolidayItem {
  final String heading;

  HeadingItem(this.heading);
}

class MessageItem implements ListHolidayItem {
  final String title;
  final DateTime dateFrom;
  final DateTime dateTo;

  MessageItem(this.title, this.dateFrom, this.dateTo);
}

class HomePage extends StatelessWidget {
  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Holidays')),
      drawer: buildDrawer(context, route),
      body: HomeBody(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, CreatePage.route);
            },
            tooltip: 'Add',
            child: Icon(Icons.add),
          )
        ],
      ),
    );
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

          items.add(MessageItem(model.title, dF, dT));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ListView.builder(
          itemCount: items.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, position) {
            final item = items[position];

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
                subtitle: Text(
                    item.dateFrom.toString() + ' - ' + item.dateTo.toString()),
              );
            }
          }),
    );
  }
}