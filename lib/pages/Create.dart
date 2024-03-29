import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holiday2/helpers/Date.dart';
import 'package:holiday2/models/ItemModel.dart';
import 'package:holiday2/providers/ItemProvider.dart';
import 'package:holiday2/ui/DatePickerModal.dart';

class CreatePage extends StatelessWidget {
  static const String route = '/create';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text('Create Holiday'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop()
            )),
        //drawer: buildDrawer(context, route),
        body: CreateForm());
  }
}

class CreateForm extends StatefulWidget {
  @override
  CreateFormState createState() {
    return CreateFormState();
  }
}

class CreateFormState extends State<CreateForm> {
  TextEditingController _controllerTitle = TextEditingController(text: '');
  final ValueNotifier<DateTime> _controllerFrom = ValueNotifier(DateTime.now());
  final ValueNotifier<DateTime> _controllerTo = ValueNotifier(DateTime.now());

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controllerTitle.dispose();
    _controllerFrom.dispose();
    _controllerTo.dispose();

    super.dispose();
  }

  Widget _buildTitleField(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.create),
      title: new TextField(
        controller: _controllerTitle,
        decoration: new InputDecoration(
          hintText: "Title",
        ),
      ),
    );
  }

  Widget _buidDate(BuildContext context, ValueNotifier _controller) {
    return ListTile(
        leading: const Icon(Icons.today),
        title: const Text('Date From'),
        subtitle: Text(DateHelper.dateHourFormat(_controller.value)),
        onTap: () {
          showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) {
              return new DatePickerModal(
                  widget: new CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: _controller.value,
                onDateTimeChanged: (DateTime newDateTime) {
                  if (mounted) {
                    setState(() => _controller.value = newDateTime);
                  }
                },
              ));
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTitleField(context),
          _buidDate(context, _controllerFrom),
          _buidDate(context, _controllerTo),
          Align(
            alignment: AlignmentDirectional.center,
            child: RaisedButton(
              onPressed: () {
                String title = _controllerTitle.text.toString();
                String dateTimeFrom = _controllerFrom.value.toString();
                String dateTimeTo = _controllerTo.value.toString();

                var model = new ItemModel(
                    title,
                    DateTime.parse(dateTimeFrom).millisecondsSinceEpoch,
                    DateTime.parse(dateTimeTo).millisecondsSinceEpoch);

                var provider = new ItemProvider();
                provider.insert(model);

                Timer.run(() {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("Item $title created successfully!"),
                        );
                      });
                });

                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
