import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holiday2/helpers/Database.dart';
import 'package:holiday2/helpers/Date.dart';
import 'package:holiday2/models/ItemModel.dart';
import 'package:holiday2/models/SettingsModel.dart';
import 'package:holiday2/providers/SettingsProvider.dart';
import 'package:holiday2/ui/DatePickerModal.dart';

final String SettingsPage_column_country = 'settings_country';
final String SettingsPage_column_days = 'settings_days';
final String SettingsPage_column_dateFrom = 'settings_date_from';

const List<String> countries = <String>[
  'England',
  'Northern Ireland',
  'Scotland',
  'Wales'
];

class SettingsTab extends StatelessWidget {
  static const String route = '/settings';

  @override
  Widget build(BuildContext context) {
    return CreateForm();
  }
}

// Create a Form widget.
class CreateForm extends StatefulWidget {
  @override
  CreateFormState createState() => CreateFormState();
}

class CreateFormState extends State<CreateForm> {
  var provider = new SettingsProvider();

  ValueNotifier<int> _controllerCountry = ValueNotifier(0);
  TextEditingController _controllerDays = TextEditingController(text: '');
  ValueNotifier<DateTime> _controllerDate =
      ValueNotifier(new DateTime(DateTime.now().year));

  @override
  void initState() {
    super.initState();

    provider.byKey(SettingsPage_column_country).then((data) {
      setState(() => _controllerCountry.value =
          data is SettingsModel ? int.parse(data.value) : 0);
    });
    provider.byKey(SettingsPage_column_days).then((data) {
      setState(() =>
          _controllerDays.text = data is SettingsModel ? data.value : '23');
    });
    provider.byKey(SettingsPage_column_dateFrom).then((data) {
      setState(() {
        if (data is SettingsModel) {
          _controllerDate.value = DateTime.parse(data.value);
        }
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controllerCountry.dispose();
    _controllerDays.dispose();
    _controllerDate.dispose();

    super.dispose();
  }

  void _onClickReset() async {
    var db = await DatabaseHelper.instance.database;
    db.rawDelete('DELETE FROM $ItemModel_table;');
    db.rawDelete('DELETE FROM $SettingsModel_table;');

    setState(() {
      _controllerCountry.value = 0;
      _controllerDays.text = '23';
      _controllerDate.value = new DateTime(DateTime.now().year);
    });

    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("App has been cleaned up!")));
  }

  void _onClickSave() async {
    var country = _controllerCountry.value;
    var days = _controllerDays.text;
    var date = _controllerDate.value;

    var db = await DatabaseHelper.instance.database;
    db.execute('''
    REPLACE INTO $SettingsModel_table ($SettingsModel_column_key, $SettingsModel_column_value)
      VALUES ('$SettingsPage_column_country', '$country'),
        ('$SettingsPage_column_days', '$days'),
        ('$SettingsPage_column_dateFrom', '$date');
    ''');
  }

  Widget _buidDaysPicker(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Holidays per year (days)'),
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

  Widget _buidStartPicker(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) {
              return new DatePickerModal(
                  widget: new CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _controllerDate.value,
                onDateTimeChanged: (DateTime newDateTime) {
                  if (mounted) {
                    setState(() => _controllerDate.value = newDateTime);
                  }
                },
              ));
            },
          );
        },
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date Start'),
                Text(DateHelper.dateFormat(_controllerDate.value)),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buidDaysPicker(context),
        _buidCountryPicker(context),
        _buidStartPicker(context),
        Align(
            alignment: AlignmentDirectional.center,
            child: RaisedButton(
              onPressed: _onClickSave,
              child: Text('Save'),
            )),
        Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
            child: Divider(color: Colors.black)),
        Align(
            alignment: AlignmentDirectional.center,
            child: RaisedButton(
              onPressed: _onClickReset,
              child: Text('Reset APP'),
              color: Colors.red,
              textColor: Colors.white,
            ))
      ],
    );
  }
}
