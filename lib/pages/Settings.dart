import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holiday2/ui/DatePickerModal.dart';
import 'package:holiday2/ui/drawer.dart';

const List<String> countries = <String>[
  'England',
  'Northern Ireland',
  'Scotland',
  'Wales'
];

class SettingsPage extends StatelessWidget {
  static const String route = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Settings')),
        drawer: buildDrawer(context, route),
        body: CreateForm());
  }
}

// Create a Form widget.
class CreateForm extends StatefulWidget {
  @override
  CreateFormState createState() => CreateFormState();
}

class CreateFormState extends State<CreateForm> {
  final ValueNotifier<int> _controllerCountry = ValueNotifier(0);
  final TextEditingController _controllerDays =
      TextEditingController(text: '23');

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controllerCountry.dispose();
    _controllerDays.dispose();

    super.dispose();
  }

  Widget _buidDaysPicker(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Number of days of holiday'),
            SizedBox(
              width: 50,
                child: new TextField(
                    controller: _controllerDays,
                    keyboardType: TextInputType.number))
          ],
        ));
  }

  Widget _buidCountryPicker(BuildContext context) {
    final FixedExtentScrollController scrollController =
        FixedExtentScrollController(initialItem: _controllerCountry.value);

    const double _kPickerItemHeight = 32.0;

    return GestureDetector(
        onTap: () {
          showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) {
              return new DatePickerModal(
                widget: CupertinoPicker(
                  scrollController: scrollController,
                  itemExtent: _kPickerItemHeight,
                  backgroundColor: CupertinoColors.white,
                  onSelectedItemChanged: (int index) {
                    setState(() => _controllerCountry.value = index);
                  },
                  children:
                      List<Widget>.generate(countries.length, (int index) {
                    return Center(
                      child: Text(countries[index]),
                    );
                  }),
                ),
              );
            },
          );
        },
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Country'),
                Text(countries[_controllerCountry.value]),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      _buidDaysPicker(context),
      _buidCountryPicker(context)
    ]);
  }
}
